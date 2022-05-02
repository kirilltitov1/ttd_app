//
//  LoginService.swift
//  Application
//
//  Created by Kirill Titov on 06.06.2021.
//

import Foundation
import RxSwift
import Alamofire

protocol LoginServiceProtocol {
    func auth(_ email: String, _ password: String) -> Single<User>
}

class LoginService: LoginServiceProtocol {
    func auth(
        _ email: String = UserSingleton.instance.email,
        _ password: String = UserSingleton.instance.passwordHash
        ) -> Single<User> {
        let url = Constants.Path.User.findUser(email, password)
        
        return Single<User>.create { single in
            AF.request(url, method: .get)
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
