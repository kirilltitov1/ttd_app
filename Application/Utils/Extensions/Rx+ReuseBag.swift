//
//  Rx+reuseBage.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import UIKit
import RxSwift


protocol Reusable where Self: UIView {
    static var reuseIdentifier: String { get }
}

@objc protocol ReusablePrepareable: class {
    func prepareForReuse()
}

extension UITableViewCell: Reusable, ReusablePrepareable { }
extension UICollectionViewCell: Reusable, ReusablePrepareable { }

extension Reactive where Base: ReusablePrepareable {
    var prepareForReuse: Observable<Void> {
        return sentMessage(#selector(Base.prepareForReuse)).map { _ in }
    }
}

private var associatedDisposeBag: Int8 = 0

extension Reusable where Self: ReusablePrepareable {
    var reuseBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        
        if let bag = objc_getAssociatedObject(self, &associatedDisposeBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(self, &associatedDisposeBag, bag, .OBJC_ASSOCIATION_RETAIN)
        rx.prepareForReuse
            .subscribe(onNext: { [weak self] _ in
                objc_setAssociatedObject(self, &associatedDisposeBag, nil, .OBJC_ASSOCIATION_RETAIN)
            })
            .disposed(by: bag)
        
        return bag
    }
}
