//
//  FilmsService.swift
//  Application
//
//  Created by Kirill Titov on 06.06.2021.
//

import Foundation
import RxSwift
import Alamofire

final class FilmsService {
    
    let errorParser: ErrorParser
    
    init() {
        self.errorParser = ErrorHandler()
    }
    
    func loadFilms() -> Single<[Film]> {
        
        let url = Constants.Path.Films.allFilms()
        
        return Single<[Film]>.create { single in
            AF.request(url)
                .responseDecodable(of: [Film].self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        self.errorParser.parser(parseError: error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func loadGenres(to film: Film) -> Single<[Genre]> {
        let url = Constants.Path.Films.filmGenres(filmID: film.id ?? "")
        
        return Single<[Genre]>.create { single in
            AF.request(url)
                .responseDecodable(of: [Genre].self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        self.errorParser.parser(parseError: error)
                    }
                }
            return Disposables.create()
        }
    }
    func loadReviews(to film: Film) -> Single<[Review]> {
        let url = Constants.Path.Films.filmReviews(filmID: film.id ?? "")
        
        return Single<[Review]>.create { single in
            AF.request(url)
                .responseDecodable(of: [Review].self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        self.errorParser.parser(parseError: error)
                    }
                }
            return Disposables.create()
        }
    }
    func loadFilmBy(prefix: String) -> Single<[Film]> {
        let url = Constants.Path.Films.filmByPrefix(prefix: prefix)
        
        return Single<[Film]>.create { single in
            AF.request(url)
                .responseDecodable(of: [Film].self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        self.errorParser.parser(parseError: error)
                    }
                }
            return Disposables.create()
        }
    }
}
