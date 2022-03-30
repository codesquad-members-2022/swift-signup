//
//  PasswordExpressionChecker.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import Foundation

final class PasswordExpressionChecker:RegularExpressionCheckable {
    private static let regex = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,16}"
    func check(expression: String) -> Bool {
        return expression.range(of: PasswordExpressionChecker.regex, options: .regularExpression) != nil
    }
}
