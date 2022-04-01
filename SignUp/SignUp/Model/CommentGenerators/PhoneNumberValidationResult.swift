//
//  PasswordCommentConfirmGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class PhoneNumberValidationResult: ValidationResult {
    var commentColor: CommentColor {
        return state == .good ? .green : .red
    }
    var state: ValidationResultState = .bad
    
    var validateResult = [NSTextCheckingResult]()
    
    var spottedRangeCount: Int {
        validateResult.reduce(0) { partialResult, result in
            result.numberOfRanges
        }
    }
    
    func validateResultState(in string: String, using results: [NSTextCheckingResult]) {
        validateResult = results
        state = (spottedRangeCount == string.count ? .good : .bad)
    }
    
    func commentRepresentation(in string: String) -> String {
        switch state {
        case .good:
            return "사용가능한 ID입니다."
        case .bad:
            return "적절하지 않은 전화번호입니다."
        }
    }
}
