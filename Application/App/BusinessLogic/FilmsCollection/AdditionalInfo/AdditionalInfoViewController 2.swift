//
//  AdditionalInfoViewController.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import UIKit
import RxSwift
import RxCocoa
import CasePaths

class AdditionalInfoViewController: UIViewController, showAlert {
    
    let reactor: AdditionalInfoReactor
    let disposeBag: DisposeBag
    let additionalView: AdditionalInfoView = AdditionalInfoView()
    let table: UITableView = UITableView()
    
    init(reactor: AdditionalInfoReactor, disposeBag: DisposeBag) {
        self.reactor = reactor
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(AdditionalTableViewCell.self, forCellReuseIdentifier: AdditionalTableViewCell.reuseIdentifier)
        table.allowsSelection = false
        
        setupBindings()
        layout()
        
        reactor.action.onNext(.loadReviews)
        reactor.action.onNext(.loadGenres)
    }
    
    private func setupBindings() {        
        reactor.state
            .map(\.film)
            .subscribe(onNext: { [weak self] film in
                guard let self = self else { return }
                self.additionalView.setup(by: film)
            }).disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map {  Array(repeating: AdditionalInfoViewModel.init(film: $0.film), count: $0.film.reviews?.count ?? 0) }
            .bind(to: table.rx.items(cellIdentifier: AdditionalTableViewCell.reuseIdentifier, cellType: AdditionalTableViewCell.self)) { row, model, cell in
                
                cell.setup(by: model, row: row)
                
                cell.rmReview.rx.tapGesture()
                    .when(.recognized)
                    .compactMap{ _ in AdditionalInfoReactor.Action.rmReviewBy(id: row) }
                    .bind(to: self.reactor.action)
                    .disposed(by: cell.reuseBag)
                
            }.disposed(by: disposeBag)
        
        additionalView.addReview.rx
            .tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                    self.reactor.action
                        .onNext(.addReview(text: self.additionalView.textField.text ?? ""))
            }).disposed(by: disposeBag)
    }
    
    func layout() {
        view.addSubviews(additionalView, table)
        table.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(300)
            $0.top.equalTo(additionalView.snp.bottom)
        }
        
        additionalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
