//
//  PasswordConfirmValidationResult.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/31.
//

import Foundation

class PasswordConfirmValidationResult: ValidationResult {
    var commentColor: CommentColor {
        return state == .good ? .green : .red
    }
    var state: ValidationResultState = .bad
    
    /// 바뀌면 안되게 관리가 필요함.
    var validateResult = [NSTextCheckingResult]()
    
    var spottedString: String {
        validateResult.reduce("") { partialResult, result in
            result.replacementString ?? ""
        }
    }
    
    func validateResultState(in string: String, using results: [NSTextCheckingResult]) {
        validateResult = results
        state = (spottedString == string ? .good : .bad)
    }
    
    func compareValidate(in string: String, compare: String) {
        state = (compare == string ? .good : .bad)
    }
    
    func commentRepresentation(in string: String) -> String {
        switch state {
        case .good:
            return "사용가능한 비밀번호입니다."
        case .bad:
            return "비밀번호가 일치하지 않습니다. 다시 확인해주시기 바랍니다."
        }
    }
}
