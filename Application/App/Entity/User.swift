//
//  User.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation

struct User: Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id: String?
    
    var reviews: [Review]?
    
    var fio: String?

    var email: String
    
    var passwordHash: String
    
    var userRights: Int


    init(
        id: String? = nil,
        reviews: [Review]? = nil,
        fio: String? = nil,
        email: String,
        passwordHash: String,
        userRights: Int
    ) {
        self.id = id
        self.reviews = reviews
        self.fio = fio
        self.email = email
        self.passwordHash = passwordHash
        self.userRights = userRights
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case reviews = "review"
//        case fio = "fio"
//        case email = "email"
//        case passwordHash = "password_hash"
//        case userRights = "userRights"
//    }
}
