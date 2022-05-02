//
//  Filmography.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation


struct Filmography {
    
    var id: UUID?
    
    var actor: Actor
    
    var film: Film
    
    init(
        id: UUID? = nil,
        actor: Actor,
        film: Film
    ) throws {
        self.id = id
        self.actor = actor
        self.film = film
    }
    enum CodingKeys: String, CodingKey {
        case actor = "actor_id"
        case films = "film_id"
    }
}
