//
//  MockServerAuth.swift.swift
//  Testing_lab_1
//
//  Created by Kirill Titov on 29.12.2021.
//

import Foundation
import RxBlocking
import RxSwift
@testable import Application

enum ErrStub: Error {
    case error
}


class MockUserServer: LoginServiceProtocol, RegistrationServiceProtocol {
    static func register(user: User) -> Single<User> {
        return  MockUserServer.isIDValide(user: user) ? .just(user) : .error(ErrStub.error)
    }
    
    func auth(_ email: String, _ password: String) -> Single<User> {
        let user = User(id: nil, reviews: [], fio: nil, email: email, passwordHash: password, userRights: 1)
        
        return MockUserServer.isIDValide(user: user) ? .just(user) : .error(ErrStub.error)
    }
    
    private static func isUserValide(user: User) -> Bool {
        return isIDValide(user: user) && isEmailValide(user: user)
    }
    
    private static func isIDValide(user: User) -> Bool {
        return user.id == .none
    }
    
    private static func isEmailValide(user: User) -> Bool {
        return user.email == UserAtribute.expectedEmail.rawValue
    }
}

