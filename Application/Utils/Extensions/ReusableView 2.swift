//
//  ReusableView.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
// https://stephenf.codes/blog/easy-to-use-cell-reuse-extensions

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    internal static var reuseIdentifier: String {
        return String(describing: self)
    }
}


extension UITableViewCell: ReusableView { }
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}


extension UICollectionViewCell: ReusableView { }
extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
