//
//  PasswordCommentConfirmGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class PhoneNumberValidationResult: ValidationResult {
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
            if string.count > 20 && string.count < 5 {
                return "5~20자 내의 ID만 사용 가능합니다."
            }
            
            if validateResult.count > 0 {
                return "소문자, 숫자, 특수기호(-)(_) 만 사용할 수 있습니다."
            }
            
            return "아이디가 적절하지 않습니다. 다시 확인해주시기 바랍니다."
        }
    }
}
