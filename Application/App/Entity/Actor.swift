//
//  Actor.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation

struct Actor: Codable {
    
    var id: UUID?
    
    var fio: String
    
    var films: [Film]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fio = try container.decode(String.self, forKey: .fio)
        films = try container.decode([Film].self, forKey: .films)
    }
    
    init(
        id: UUID? = nil,
        fio: String,
        films: [Film]
    ) {
        self.id = id
        self.fio = fio
        self.films = films
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fio = "FIO"
        case films = "films"
    }
}
