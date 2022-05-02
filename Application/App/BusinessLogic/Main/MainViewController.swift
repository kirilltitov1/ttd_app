//
//  MainViewController.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import CasePaths

class MainViewController: UIViewController {
    // MARK: - PARAMETERS
    
    let reactor: MainReactor
    let disposeBag: DisposeBag
    let mainView = MainView()
    
    // MARK: - INIT
    
    init(
        reactor: MainReactor,
        disposeBag: DisposeBag
    ) {
        self.reactor = reactor
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    // MARK: - SETUPBINDINGS
    
    private func setupBindings() {
        mainView.loginButton.rx
            .tapGesture().when(.recognized)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.reactor.action.onNext(.login)
            }).disposed(by: disposeBag)
        mainView.registrationButton.rx
            .tapGesture().when(.recognized)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.reactor.action.onNext(.register)
            }).disposed(by: disposeBag)
    }
}
