//
//  Film.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import Foundation
import UIKit

struct Film: Codable, Equatable {
    
    var id: String?
    
    var reviews: [Review]?
    
    var name: String
    
    var ageRating: Int
    
    var boxOffice: Int
    
    var date: String
    
    var actors: [Actor]?
    
    var image: String?
    
    var genres: [Genre]?
    
    init(
        id: String? = nil,
        reviews: [Review]? = nil,
        name: String = "",
        genre: Genre? = nil,
        ageRating: Int = 0,
        boxOffice: Int = 0,
        date: String = "",
        actors: [Actor]? = nil,
        genres: [Genre]? = nil,
        image: String? = nil
    ) {
        self.id = id
        self.reviews = reviews
        self.name = name
        self.ageRating = ageRating
        self.boxOffice = boxOffice
        self.date = date
        self.actors = actors
        self.genres = genres
        self.image = image
    }
    
    static func == (lhs: Film, rhs: Film) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case reviews = "reviews"
        case date = "date"
        case actors = "actors"
        case genres = "genres"
        case ageRating = "age_rating"
        case boxOffice = "box_office"
    }
}
