//
//  UserBuilder.swift
//  Testing_lab_1
//
//  Created by Kirill Titov on 29.12.2021.
//

import Foundation
@testable import Application

enum UserAtribute: String {
    case expectedFirstName = "expectedFirstName",
         unexpectedFirstName = "unexpectedFirstName"
    
    case expectedLastname = "expectedLastname",
         unexpectedLastname = "unexpectedLastname"
    
    case expectedEmail = "expectedEmail",
         unexpectedEmail = "unexpectedEmail"
    
    case expectedPassword_hash = "expectedPassword_hash",
         unexpectedPassword_hash = "unexpectedPassword_hash"
    
    case expectedPhone = "expectedPhone",
         unexpectedPhone = "unexpectedPhone"
    
    case expectedUserRights = "1",
         unexpectedUserRights = "99"
         
}

class UserStubBuilder {
    
    private var id: String?
    
    private var reviews: [Review]?
    
    private var fio: String? = UserAtribute.expectedFirstName.rawValue

    private var email: String = UserAtribute.expectedEmail.rawValue
    
    private var passwordHash: String = UserAtribute.expectedPassword_hash.rawValue
    
    private var userRights: String = UserAtribute.expectedUserRights.rawValue
    
    func makeInvalide() -> UserStubBuilder {
        self.id = UUID().uuidString
        return self
    }
    
    func makeValide() -> UserStubBuilder {
        self.id = nil
        return self
    }
    
    func build() -> User {
        return User(id: id,
                    reviews: reviews,
                    fio: fio,
                    email: email,
                    passwordHash: passwordHash,
                    userRights: Int(userRights) ?? 0
        )
    }
}

