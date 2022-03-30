//
//  IDCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class IDValidationResult: ValidationResult {
    
    var state: ValidationResultState = .bad
    
    var commentColor: CommentColor {
        return state == .good ? .green : .red
    }
    
    var validateResult = [NSTextCheckingResult]()
    
    var spottedRangeCount: Int {
        validateResult.reduce(0) { partialResult, result in
            result.range.length
        }
    }
    
    func validateResultState(in string: String, using results: [NSTextCheckingResult]) {
        validateResult = results
        if (5...20 ~= string.count) && (spottedRangeCount == string.count) {
            state = .good
            return
        }
        
        state = .bad
    }
    
    func commentRepresentation(in string: String) -> String {
        switch state {
        case .good:
            return "사용가능한 ID입니다."
        case .bad:
            if string.count > 20 || string.count < 5 {
                return "5~20자 내의 ID만 사용 가능합니다."
            }
            
            if spottedRangeCount != string.count {
                return "소문자, 숫자, 특수기호(-)(_) 만 사용할 수 있습니다."
            }
            
            return "아이디가 적절하지 않습니다. 다시 확인해주시기 바랍니다."
        }
    }
}
