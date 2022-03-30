//
//  EmailCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class EmailValidationResult: ValidationResult {
    var commentColor: CommentColor = .red
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
            if validateResult.count != 3 {
                return "이메일 형식이 맞지 않습니다."
            }
            
            return "Email이 적절하지 않습니다. 다시 확인해주시기 바랍니다."
        }
    }
}
