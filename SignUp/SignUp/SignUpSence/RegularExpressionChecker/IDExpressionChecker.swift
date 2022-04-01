//
//  IDExpressionChecker.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import Foundation

final class IDExpressionChecker:RegularExpressionCheckable {
    private static let regex = "^[a-z0-9_-]{5,20}$"
    
    func check(expression: String) -> TextFieldInputResult {
        if expression.range(of: IDExpressionChecker.regex, options: .regularExpression) != nil {
            return TextFieldInputResult.idResult(result: .success)
        } else {
            return TextFieldInputResult.idResult(result: .failure(type: .notValidateForm))
        }
    }
}
