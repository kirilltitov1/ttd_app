//
//  ReviewService.swift
//  Application
//
//  Created by Kirill Titov on 12.06.2021.
//

import Foundation
import Alamofire
import RxSwift

final class ReviewService {
    static func addReview(filmID: String, text: String) -> Single<Review> {
        
        let url = Constants.Path.Reviews.filmReviews(filmID: filmID, text: text)
        
        return Single<Review>.create { single in
            AF.request(url)
                .responseDecodable(of: Review.self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        print(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    struct DeleteResponse: Codable {
        let name: String
    }
    
    static func rmReview(id: String) -> Single<String> {
        let url = Constants.Path.Reviews.deleteReview(reviewID: id)
        
        return Single<String>.create { single in
            AF.request(url, method: .delete)
                .responseDecodable(of: DeleteResponse.self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success.name))
                    case let .failure(error):
                        print(error)
                    }
                }
            return Disposables.create()
        }
    }
}
