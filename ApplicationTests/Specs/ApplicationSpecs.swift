//
//  ApplicationSpecs.swift
//  ApplicationTests
//
//  Created by Kirill Titov on 14.06.2021.
//

import Foundation
import Quick
import Nimble

@testable import Application

class ApplicationSpecs: QuickSpec {
    override func spec() {
        describe(String(describing: self)) {
            context("when use Nimble and Quick") {
                it("should pass") {
                    expect(true).to(beTrue())
                }
            }
        }
    }
}
