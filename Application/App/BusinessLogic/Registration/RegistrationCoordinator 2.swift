//
//  RegistrationCoordinator.swift
//  Application
//
//  Created by Kirill Titov on 01.06.2021.
//

import RxSwift
import RxCocoa
import CasePaths

final class RegistrationCoordinator: BaseCoordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        let reactor = RegistrationReactor(disposeBag: disposeBag)
        let viewController = RegistrationViewController(reactor: reactor, disposeBag: disposeBag)
        
        // MARK: - BINDINGS
        /// going to films
        
        reactor.action.compactMap(/RegistrationReactor.Action.apply)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.didRegister()
            }).disposed(by: disposeBag)
        
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.viewControllers.append(viewController)
    }
}

protocol RegistrationDidRegister {
    func didRegister()
}

extension RegistrationCoordinator: RegistrationDidRegister {
    func didRegister() {
        print("RegistrationCoordinator: Register pressed")
        let coordinator = LoginCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
