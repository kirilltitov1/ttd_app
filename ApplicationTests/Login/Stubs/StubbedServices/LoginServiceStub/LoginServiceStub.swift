//
//  LoginServiceStub.swift
//  ApplicationTests
//
//  Created by Kirill Titov on 14.06.2021.
//

import Foundation
import RxSwift
import Stubber

@testable import Application

class LoginServiceStub: LoginServiceProtocol {
    func auth(_ email: String, _ password: String) -> Single<User> {
        return Stubber.invoke(auth, args: (email, password), default: .never())
    }
}
