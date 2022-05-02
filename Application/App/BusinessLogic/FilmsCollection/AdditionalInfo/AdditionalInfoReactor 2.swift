//
//  AdditionalInfoReactor.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import Foundation

import Foundation
import ReactorKit

class AdditionalInfoReactor: Reactor, showAlert {
    enum Action {
        case setFilm(film: Film)
        case loadReviews
        case loadGenres
        case addReview(text: String)
        case didAddReview(review: Review)
        case rmReviewBy(id: Int)
    }
    
    enum Mutation {
        case setFilm(film: Film)
        case setReviews(reviews: [Review])
        case setGenres(genres: [Genre])
        case empty
    }
    
    struct State {
        private(set) var film: Film
    }
    
    private let disposeBag: DisposeBag
    private let filmService = FilmsService()
    var initialState: AdditionalInfoReactor.State
    
    init(film: Film, disposeBag: DisposeBag) {
        initialState = State(film: film)
        self.disposeBag = disposeBag
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        case let .setFilm(film):
            return .just(.setFilm(film: film))
            
        case .loadGenres:
            return filmService.loadGenres(to: currentState.film)
                .map(Mutation.setGenres).asObservable()
            
        case .loadReviews:
            return filmService.loadReviews(to: currentState.film)
                .map(Mutation.setReviews).asObservable()
            
        case let .addReview(text):
            ReviewService.addReview(filmID: (currentState.film.id ?? ""), text: text).subscribe(onSuccess: { [weak self] review in
                guard let self = self else { return }
                self.action.onNext(.didAddReview(review: review))
            },
            onFailure: { err in
                self.showAlert(message: "Ругательства запрещены!!!")
            }).disposed(by: disposeBag)
            return .just(.empty)
        case let .didAddReview(review):
            return .just(.setReviews(reviews: (currentState.film.reviews ?? [])+[review]))
        case let .rmReviewBy(id):
            return ReviewService
                .rmReview(id: (currentState.film.reviews?[id].id ?? ""))
                .map { _ in
                    let elem = self.currentState.film.reviews?[id].id
                    return Mutation.setReviews(reviews: (self.currentState.film.reviews?
                                                            .filter { $0.id != elem}) ?? [] )
                }
                .asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State
        switch mutation {
        case let .setFilm(film):
            newState = State(film: film)
        case let .setReviews(reviews):
            var film = state.film
            film.reviews = reviews
            newState = State(film: film)
        case let .setGenres(genres):
            var film = state.film
            film.genres = genres
            newState = State(film: film)
        case .empty:
            newState = currentState
        }
        return newState
    }
}
