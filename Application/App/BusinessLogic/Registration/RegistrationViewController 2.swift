//
//  RegistrationViewController.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import CasePaths

class RegistrationViewController: UIViewController {

    // MARK: - PARAMETERS
    
    let reactor: RegistrationReactor
    let disposeBag: DisposeBag
    let registrationView = RegistrationView()
    
    // MARK: - INIT
    
    init(
        reactor: RegistrationReactor,
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
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    deinit {
        print("deinit (RegistrationViewController)")
    }

    // MARK: - SETUPBINDINGS
    
    private func setupBindings() {
        registrationView.passwordTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(DispatchTimeInterval.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.reactor.action.onNext(.passwordInput(password: $0))
            }).disposed(by: disposeBag)
        
        registrationView.loginTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(DispatchTimeInterval.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.reactor.action.onNext(.loginInput(login: $0))
            }).disposed(by: disposeBag)
        
        registrationView.fioTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(DispatchTimeInterval.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.reactor.action.onNext(.fioInput(fio: $0))
            }).disposed(by: disposeBag)
        
        registrationView.applyButton.rx
            .tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.reactor.action.onNext(.check)
            }.disposed(by: disposeBag)
    }

}
