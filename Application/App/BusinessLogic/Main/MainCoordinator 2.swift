//
//  MainCoordinator.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import Foundation
import RxSwift
import CasePaths

class MainCoordinator: BaseCoordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        let reactor = MainReactor()
        let viewController = MainViewController(reactor: reactor, disposeBag: disposeBag)
        
        // MARK: - BINDINGS
        /// going to login
        reactor.action.compactMap(/MainReactor.Action.login)
            .debug("🚸 MainCoordinator (login)")
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.didLogin()
            }).disposed(by: disposeBag)
        /// going to register
        reactor.action.compactMap(/MainReactor.Action.register)
            .debug("🚸 MainCoordinator (register)")
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.didRegister()
            }).disposed(by: disposeBag)
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.viewControllers = [viewController]
    }
}

protocol MainDidLogin {
    func didLogin()
}

extension MainCoordinator: MainDidLogin {
    func didLogin() {
        print("MainCoordinator: Login pressed")
        let coordinator = LoginCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}

protocol MainDidRegister {
    func didRegister()
}

extension MainCoordinator: MainDidRegister {
    func didRegister() {
        print("MainCoordinator: Register pressed")
        let coordinator = RegistrationCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
