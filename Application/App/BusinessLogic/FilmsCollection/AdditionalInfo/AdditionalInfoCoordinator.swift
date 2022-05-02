//
//  AdditionalInfoCoordinator.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import Foundation
import RxSwift
import RxCocoa
import CasePaths

class AdditionalInfoCoordinator: BaseCoordinator {
    let disposeBag = DisposeBag()
    
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    override func start() {
        let reactor = AdditionalInfoReactor(film: film, disposeBag: disposeBag)
        let viewController = AdditionalInfoViewController(reactor: reactor, disposeBag: disposeBag)
        
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.viewControllers.append(viewController)
    }
}
