//
//  UserSingletone.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation

class UserSingleton {
    
    // MARK: - Parameters
    
    var user: User = User(email: "kirill.titov@outlook.com",
                          passwordHash: "123456",
                          userRights: 2)
    
    // MARK: - Shared
    
    static var instance: User = {
        let instance = UserSingleton().user
        
        return instance
    }()

    // MARK: - private init
    
    private init() {}
}
