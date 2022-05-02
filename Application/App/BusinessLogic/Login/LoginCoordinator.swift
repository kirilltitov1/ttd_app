//
//  LoginCoordinator.swift
//  Application
//
//  Created by Kirill Titov on 01.06.2021.
//

import Foundation
import RxSwift
import RxCocoa
import CasePaths

class LoginCoordinator: BaseCoordinator {
    let disposeBag = DisposeBag()
    
    override func start() {
        let reactor = LoginReactor(disposeBag: disposeBag)
        let viewController = LoginViewController(reactor: reactor, disposeBag: disposeBag)
        
        // MARK: - BINDINGS
        //// going to films
        reactor.action.compactMap(/LoginReactor.Action.apply)
            .debug("🚸 LoginCoordinator (start)")
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didLogin()
            }).disposed(by: disposeBag)
        
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.viewControllers.append(viewController)
    }
}

protocol DidLoginCoordinator {
    func didLogin()
}

extension LoginCoordinator: DidLoginCoordinator {
    func didLogin() {
        print("LoginCoordinator: Login pressed")
        let coordinator = FilmsCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
