//
//  MockLoginReactorBuilder.swift
//  Testing_lab_1
//
//  Created by Kirill Titov on 05.01.2022.
//

import Foundation
import RxSwift

class StubLoginReactorBuilder {
    
    func build(disposeBag: DisposeBag) -> StubUserLoginReactor {
        return StubUserLoginReactor(disposeBag: disposeBag)
    }
}
