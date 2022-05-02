//
//  Rewiews.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation

struct Review: Codable {

    var id: String?
    
    var user: User
    
    class User: Codable {
        var id: String
    }
    
    var film: Film
    
    class Film: Codable {
        var id: String
    }
    
    var text: String
    
    
    init(
        id: String? = nil,
        user: User,
        film: Film,
        text: String
    ) {
        self.id = id
        self.user = user
        self.text = text
        self.film = film
    }
}
