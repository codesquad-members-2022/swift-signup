//
//  IDRegularExpression.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import Foundation

final class IDExpressionChecker:RegularExpressionCheckable {
    private static let regex = "[a-z0-9-_]{5,20}"
    func check(expression: String) -> Bool {
        return expression.range(of: IDExpressionChecker.regex, options: .regularExpression) != nil
    }
}
