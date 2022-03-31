//
//  PasswordExpressionChecker.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import Foundation

final class PasswordExpressionChecker:RegularExpressionCheckable {
    
    func check(expression: String) -> TextFieldInputResult {
        //nil값이면 통과못한 Case
        let nonPassCases = PasswordRegex.allCases.filter {
            expression.range(of: $0.rawValue, options: .regularExpression) == nil
        }
        guard let result = nonPassCases.first else { return TextFieldInputResult.passwordResult(result: .success) }
        return TextFieldInputResult.passwordResult(result: .failure(type: result))
    }
}


