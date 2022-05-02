//
//  MockLoginUserReactor.swift.swift
//  Testing_lab_1
//
//  Created by Kirill Titov on 05.01.2022.
//

import Foundation
import ReactorKit
import RxSwift

class StubUserLoginReactor: Reactor, Equatable {
    static func == (lhs: StubUserLoginReactor, rhs: StubUserLoginReactor) -> Bool {
        return lhs.isStubEnabled == rhs.isStubEnabled
    }
    
    enum Action {
        case apply
    }
    
    enum Mutation {
        case setApply
    }
    
    struct State {
        var isApplyPressed: Bool = false
    }
    
    
    private let disposeBag: DisposeBag
    
    var initialState: StubUserLoginReactor.State
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apply:
            return .just(.setApply)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        let newState: State
        switch mutation {
        case .setApply:
            newState = State(isApplyPressed: false)
        }
        return newState
    }
    
    init(disposeBag: DisposeBag) {
        initialState = State()
        self.disposeBag = disposeBag
    }
}
