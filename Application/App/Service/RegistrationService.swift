//
//  RegistrationService.swift
//  Application
//
//  Created by Kirill Titov on 06.06.2021.
//

import Foundation
import Alamofire
import RxSwift

class RegisterResponse {
    
}

protocol RegistrationServiceProtocol {
    static func register(user: User) -> Single<User>
}

final class RegistrationService: RegistrationServiceProtocol {
    static func register(user: User = UserSingleton.instance) -> Single<User> {
        let url = Constants.Path.User.createUser()
        let params: [String:String] = ["email": user.email,
                      "fio" : user.fio ?? "",
                      "userRights" : "1",
                      "passwordHash" : user.passwordHash]
        
        return Single<User>.create { single in
            AF.request(url, method: .post, parameters: params, encoding: URLEncoding(destination: .queryString))
                .responseDecodable(of: User.self) { response in
                    switch response.result {
                    case let .success(success):
                        single(.success(success))
                    case let .failure(error):
                        print(error)
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
