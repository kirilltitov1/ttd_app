//
//  Testing_lab_1.swift
//  Testing_lab_1
//
//  Created by Kirill Titov on 29.12.2021.
//

import RxCocoa
import XCTest
import RxSwift
import RxBlocking

@testable import Application
class Testing_lab_1: XCTestCase {

    let disposeBag: DisposeBag = DisposeBag()
    var serverSut: MockUserServer!
    var userReactorSut: StubUserLoginReactor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        serverSut = MockUserServer()
        userReactorSut = StubUserLoginReactor(disposeBag: disposeBag)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        serverSut = nil
        userReactorSut = nil
    }
    
    func testUserReg() throws {
        
        // Arrange
        serverSut = MockUserServer()
        let userStub = UserStubBuilder().makeValide().build()
        
        // Act
        let result = try MockUserServer.register(user: userStub).asObservable().toBlocking().first()
        
        // Assert
        XCTAssertEqual(userStub, result)
    }
    
    func testUserAuth() throws {
        
        // Arrange
        serverSut = MockUserServer()
        let userStub = UserStubBuilder().makeValide().build()
        
        // Act
        let result = try serverSut.auth(userStub.email, userStub.passwordHash).asObservable().toBlocking().first()
        
        // Assert
        XCTAssertEqual(userStub, result)
    }
    
    func testLoginUserReactor() {
        
        // Arrange
        let userLoginReacktorStub = StubLoginReactorBuilder().build(disposeBag: disposeBag)
        
        // Act
        userReactorSut.action.onNext(.apply)
        
        // Assert
        XCTAssertEqual(userLoginReacktorStub, userReactorSut)
    }
    
    func testLoginUserReactorClassic() {
        
        // Arrange
        let userReactor = LoginReactor(disposeBag: disposeBag)
        let userReactorSuccess = LoginReactor(disposeBag: disposeBag)
        
        // Act
        userReactor.action.onNext(.apply)
        
        // Assert
        XCTAssertEqual(userReactor, userReactorSuccess)
    }
}
