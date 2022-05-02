//
//  KinoCoordinator.swift
//  Application
//
//  Created by Kirill Titov on 01.06.2021.
//

import RxSwift
import RxCocoa
import CasePaths

class FilmsCoordinator: BaseCoordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        let reactor = FilmsReactor()
        let viewController = FilmsViewController(reactor: reactor, disposeBag: disposeBag)
        
        // MARK: - BINDINGS
        /// going to films
        reactor.action
            .compactMap(/FilmsReactor.Action.selectFilm)
            .debug("⚠️ FilmsCoordinator")
            .subscribe(onNext: { [weak self] film in
                guard let self = self else { return }
                self.goToSelectedFilm(film: film)
            }).disposed(by: disposeBag)
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.viewControllers.append(viewController)
    }
}

extension FilmsCoordinator {
    
    func goToSelectedFilm(film: Film) {
        let coordinator = AdditionalInfoCoordinator(film: film)
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
