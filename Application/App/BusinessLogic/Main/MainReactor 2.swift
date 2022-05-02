//
//  MainReactor.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import Foundation
import ReactorKit

class MainReactor: Reactor {
    enum Action {
        case login
        case register
    }
    
    enum Mutation {
        case empty
    }
    
    struct State {}
    
    var initialState: MainReactor.State
    
    init() {
        initialState = State()
    }
}
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .login:
//            return .empty()
//        case .register:
//            return .empty()
//        }
//    }
 
//    func reduce(state: State, mutation: Mutation) -> State {
//        var newState: State
//        switch mutation {
//        case .empty:
//            newState = currentState
//        }
//        return newState
//    }
