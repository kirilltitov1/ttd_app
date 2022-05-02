//
//  AppCoordinator.swift
//  neighbor
//
//  Created by Maksim Romanov on 21.10.2020.
//

import UIKit
import RxSwift
import RealmSwift

final class AppCoordinator: BaseCoordinator {

	var window: UIWindow!
//	var initialState: [String:Bool]? = UserDefaults.standard.dictionary(forKey: Constants.state) as? [String:Bool]

	override func start(window: UIWindow) {
		self.window = window

//		self.navigationController.navigationBar.isHidden = true
		self.window.rootViewController = self.navigationController
		self.window.makeKeyAndVisible()

//		self.initInitialState()

//		self.isGoingToLogin()
//		self.isGoingToRegistration()

		let coordinator = MainCoordinator()
		coordinator.navigationController = self.navigationController
		self.start(coordinator: coordinator)
	}
}
//	func initInitialState() {
//		if initialState == nil {
//			UserDefaults.standard.setValue(["isLogin" : false,
//											"isRegister" : false],
//										   forKey: Constants.state)
//		}
//	}

//	@discardableResult
//	private func isGoingToLogin() -> Bool {
//		guard let state = initialState else { return false }
//		guard let isLogin = state["isLogin"] else { return false }
//
//		if isLogin {
//			toLogin()
//			return true
//		}
//		return false
//	}
//	private func toLogin() {
////		let loginCoordinator = LoginCoordinator()
////		loginCoordinator.start()
//	}
//
//	@discardableResult
//	private func isGoingToRegistration() -> Bool {
//		guard let state = initialState else { return false }
//		guard let isRegistered = state["isRegister"] else { return false }
//
//		if isRegistered {
//			toRegistration()
//			return true
//		}
//		return false
//	}
//	private func toRegistration() {
////		let registrationCoordinator = RegistrationCoordinator()
////		registrationCoordinator.start()
//	}
//
//	private func toMain() {
//
//	}
//}
