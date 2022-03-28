//
//  SignupTests.swift
//  SignupTests
//
//  Created by seongha shin on 2022/03/28.
//

import XCTest

class SignupTests: XCTestCase {

    func testIdAndPassword() {
        let model = SignUpModel()
        
        model.action.userIdEntered.send("idididid")
        model.action.passwordEntered.send("password")
        
        model.action.nextButtonTapped.send()
    }

}
