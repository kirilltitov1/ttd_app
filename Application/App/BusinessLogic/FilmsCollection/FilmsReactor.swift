//
//  KinoReactor.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import UIKit
import ReactorKit


class FilmsReactor: Reactor {
    enum Action {
        case loadFilms
        case selectFilm(film: Film)
        case loadFilmsBy(prefix: String)
    }
    
    enum Mutation {
        case setFilms(films: [Film])
        case setGenresToFilm(film: Film, genres: [Genre])
    }
    
    enum Navigation {
        case goToAddInfo
    }
    
    struct State: Equatable {
        private(set) var cells: [Film] = []
        
        static func == (lhs: FilmsReactor.State, rhs: FilmsReactor.State) -> Bool {
            lhs.cells == rhs.cells
        }
    }
    
    let initialState: FilmsReactor.State
    
    private let filmsService = FilmsService()
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadFilms:
            return filmsService.loadFilms()
                .asObservable()
                .map { return Mutation.setFilms(films: $0) }
            
        case let .loadFilmsBy(prefix):
            if prefix.isEmpty {
                return filmsService.loadFilms()
                    .asObservable()
                    .map(Mutation.setFilms)
            } else {
                return filmsService.loadFilmBy(prefix: prefix)
                    .asObservable()
                    .map(Mutation.setFilms)
            }
        case .selectFilm(_):
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State
        switch mutation {
        case let .setFilms(films):
            let new_films = films.map { Film(id: $0.id,
                                             reviews: $0.reviews,
                                             name: $0.name,
                                             genre: $0.genres?.first,
                                             ageRating: $0.ageRating,
                                             boxOffice: $0.boxOffice,
                                             date: $0.date,
                                             actors: $0.actors,
                                             genres: $0.genres,
                                             image: FilmsSingleton.instance.randomElement())
            }
            newState = State(cells: new_films)
        case .setGenresToFilm(var film, let genres):
            film.genres = genres
            newState = State(cells: currentState.cells)
        }
        return newState
    }
}
