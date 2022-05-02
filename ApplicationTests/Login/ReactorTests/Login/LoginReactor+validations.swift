////
////  LoginReactor+validations.swift
////  ApplicationTests
////
////  Created by Kirill Titov on 14.06.2021.
////
//
//import Foundation
//import Quick
//import Nimble
//import RxSwift
//import RxBlocking
//import Stubber
//import CasePaths
//
//@testable import Application
//
//extension LoginReactorTests {
//    internal func testValidations() {
//        describe("validations") {
//            self.testEmailValidation()
//            self.testPasswordValidation()
//        }
//    }
//    
//    private func testEmailValidation() {
//        context("when invalid email is entered") {
//            it("has shown invalid email error") {
//                let disposeBag = DisposeBag()
//                
//                self.loginServiceStub.auth(self.invalidEmail, self.validPassword).asObservable()
//                    .delay(.seconds(1), scheduler: MainScheduler.instance)
//                    .map { Observable.concat(Observable.just(LoginReactor.Action.loginInput(login: $0.email)),
//                                             Observable.just(LoginReactor.Action.passwordInput(password: $0.passwordHash)))
//                        .bind(to: self.loginReactor.action)
//                        .disposed(by: disposeBag)
//                    }
//                let errorMessage = "error message"
//                guard let state = try? self.loginReactor.state.skip(1).take(1).toBlocking(timeout: 5).first() else {
//                    succeed()
//                    return
//                }
//                expect(errorMessage).to(equal(errorMessage), description: "It should show the correct error message")
//            }
//        }
//    }
//    
//    private func testPasswordValidation() {
//        context("when invalid password is entered") {
//            it("has shown invalid password error") {
//                let disposeBag = DisposeBag()
//                
//                self.loginServiceStub.auth(self.invalidEmail, self.validPassword).asObservable()
//                    .delay(.seconds(1), scheduler: MainScheduler.instance)
//                    .map { Observable.concat(Observable.just(LoginReactor.Action.loginInput(login: $0.email)),
//                                             Observable.just(LoginReactor.Action.passwordInput(password: $0.passwordHash)))
//                        .bind(to: self.loginReactor.action)
//                        .disposed(by: disposeBag)
//                    }
//                
//                let errorMessage = "error message"
//                guard let state = try? self.loginReactor.state.skip(1).take(1).toBlocking(timeout: 5).first() else {
//                    succeed()
//                    return
//                }
//                expect(errorMessage).to(equal(errorMessage), description: "It should show the correct error message")
//            }
//        }
//    }
//}
