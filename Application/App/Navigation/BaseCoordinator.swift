//
//  BaseCoordinator.swift
//  neighbor
//
//  Created by Kirill Titov on 01.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator: AnyObject {
	var navigationController: UINavigationController { get set }
	var parentCoordinator: Coordinator? { get set }

	func start()
	func start(window: UIWindow)
	func start(coordinator: Coordinator)
	func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {

	var childCoordinators: [Coordinator] = []
	var parentCoordinator: Coordinator?
	var navigationController = UINavigationController()

	func start(window: UIWindow) {
		fatalError("'start(window)' method must be implemented")
	}

	func start() {
		fatalError("'start()' must be implemented")
	}

	func start(coordinator: Coordinator) {
		self.childCoordinators.append(coordinator)
		coordinator.parentCoordinator = self
		coordinator.start()
	}

	func didFinish(coordinator: Coordinator) {
		if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
			self.childCoordinators.remove(at: index)
		}
	}
}

//public protocol CoordinatorType: NSObjectProtocol {
//    var identifier: UUID { get }
//    var childCoordinators: [UUID: Any] { get set }
//    var navigationController: UINavigationController! { get set }
//}
//
//public extension CoordinatorType {
//
//    func store<T>(coordinator: BaseCoordinator<T>) {
//        coordinator.navigationController = navigationController
//        childCoordinators[coordinator.identifier] = coordinator
//    }
//
//    func free<T>(coordinator: BaseCoordinator<T>) {
//        childCoordinators[coordinator.identifier] = nil
//    }
//
//    @discardableResult
//    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
//        store(coordinator: coordinator)
//        return coordinator.start()
//            .do(onNext: { [weak self] _ in
//                if let `self` = self {
//                    self.free(coordinator: coordinator)
//                }
//            })
//    }
//}
//
//public class BaseCoordinator<ResultType>: NSObject, UINavigationControllerDelegate, CoordinatorType {
//
//    /// Typealias which will allows to access a ResultType of the Coordainator by `CoordinatorName.CoordinationResult`.
//
//    typealias CoordinationResult = ResultType
//
//    public var navigationController: UINavigationController!
//
//    func start() -> Observable<ResultType> {
//        fatalError("Coordinator Start method should be implemented by subclass.")
//    }
//
//    func noResultStart() {
//        fatalError("Coordinator noResultStart method should be implemented by subclass.")
//    }
//
//    /// UINavigationControllerDelegate
//
//    public func navigationController(
//        _ navigationController: UINavigationController,
//        didShow viewController: UIViewController,
//        animated: Bool
//    ) {
//        // ensure the view controller is popping
//        guard let transitionCoordinator = navigationController.transitionCoordinator,
//              let fromViewController = transitionCoordinator.viewController(forKey: .from),
//              !navigationController.viewControllers.contains(fromViewController) else { return }
//
//        fromViewController.popedAction.onNext(())
//        fromViewController.popedAction.onCompleted()
//    }
//
//    let disposeBag = DisposeBag()
//
//    public let identifier = UUID()
//
//    public var childCoordinators = [UUID: Any]()
//}
