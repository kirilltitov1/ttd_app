//
//  Genre.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation

struct Genre: Codable {
    
    let id: String
    
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
