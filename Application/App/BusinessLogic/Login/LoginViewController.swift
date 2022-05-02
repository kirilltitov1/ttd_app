//
//  LoginViewController.swift
//  Application
//
//  Created by Kirill Titov on 04.06.2021.
//

import UIKit
import RxSwift
import RxGesture
import CasePaths

class LoginViewController: UIViewController {

    // MARK: - PARAMETRES

    let reactor: LoginReactor
    let disposeBag: DisposeBag
    let loginView: LoginView = LoginView()
    
    // MARK: - INIT

    init(
        reactor: LoginReactor,
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
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    deinit {
        print("deinit (LoginViewController)")
    }
    
    // MARK: - BINDINGS
    
    private func setupBindings() {
        
        loginView.applyButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.reactor.action.onNext(.check)
            }.disposed(by: disposeBag)
        loginView.loginTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(DispatchTimeInterval.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.reactor.action.onNext(.loginInput(login: $0))
            }).disposed(by: disposeBag)
        loginView.passwordTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(DispatchTimeInterval.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.reactor.action.onNext(.passwordInput(password: $0))
            }).disposed(by: disposeBag)
    }

    // MARK: - LAYOUT
    
}
