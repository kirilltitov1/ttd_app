//
//  LoginReactor.swift
//  Application
//
//  Created by Kirill Titov on 04.06.2021.
//

import Foundation
import ReactorKit

class LoginReactor: Reactor, Equatable {
    static func == (lhs: LoginReactor, rhs: LoginReactor) -> Bool {
        return true
    }
    
    enum Action {
        case loginInput(login: String)
        case passwordInput(password: String)
        case check
        case apply
    }
    
    enum Mutation {
        case setLogin(login: String)
        case setPassword(password: String)
        case empty
    }
    
    struct State {}
    
    
    private let disposeBag: DisposeBag
    private let loginService = LoginService()
    var initialState: LoginReactor.State
    
    init(disposeBag: DisposeBag) {
        initialState = State()
        self.disposeBag = disposeBag
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .loginInput(login):
            return .just(.setLogin(login: login))
        case let .passwordInput(password):
            return .just(.setPassword(password: password))
        case .check:
            loginService.auth().subscribe(onSuccess: { [weak self] user in
                UserSingleton.instance = user
                guard let self = self else { return }
                self.action.onNext(.apply)
            }).disposed(by: disposeBag)
            return .just(.empty)
        case .apply:
            return .just(.empty)
        }
    }
 
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = State()
        switch mutation {
        case let .setLogin(login):
            UserSingleton.instance.email = login
        case let .setPassword(password):
            UserSingleton.instance.passwordHash = password
        case .empty:
            newState = currentState
        }
        return newState
    }
}
