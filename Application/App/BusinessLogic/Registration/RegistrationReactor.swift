//
//  RegistrationReactor.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import ReactorKit


//class RegistrationReactor: Reactor {
class RegistrationReactor: Reactor {
    enum Action {
        case loginInput(login: String)
        case fioInput(fio: String)
        case passwordInput(password: String)
        case check
        case apply
    }
    
    enum Mutation {
        case setLogin(login: String)
        case setPassword(password: String)
        case setFio(fio: String)
        case empty
    }
    
    private let disposeBag: DisposeBag

    struct State {}
    
    var initialState: RegistrationReactor.State
    
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .loginInput(login):
            return .just(.setLogin(login: login))
        case let .fioInput(fio):
            return .just(.setFio(fio: fio))
        case let .passwordInput(password):
            return .just(.setPassword(password: password))
        case .check:
            RegistrationService.register().subscribe(onSuccess: { [weak self] user in
                guard let self = self else { return }
                UserSingleton.instance = user
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
        case let .setFio(fio):
            UserSingleton.instance.fio = fio
        case let .setPassword(password):
            UserSingleton.instance.passwordHash = password
        case .empty:
            newState = currentState
        }
        return newState
    }
}

