//
//  TextFieldManger.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

import Foundation

final class SignUpViewTextFieldManger {
    
    private let signUpView:SignUpInputViewable?
    private let regualrExpressionChecker:RegularExpressionCheckable?
    private var isValidate:Bool = false
    
    init(signUpView:SignUpInputViewable?, regualrExpressionChecker:RegularExpressionCheckable?) {
        self.signUpView = signUpView
        self.regualrExpressionChecker = regualrExpressionChecker
    }
    
    func check() {
        
    }
    
    
    
    func isValidateText() {
        guard let inputView = signUpView,
              let text = inputView.getTextFieldText(),
              let checker = regualrExpressionChecker else { return  }
        let result = checker.check(expression:text)
        print(result)
    }
    
}
