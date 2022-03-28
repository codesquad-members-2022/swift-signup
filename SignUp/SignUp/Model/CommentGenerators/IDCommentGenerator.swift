//
//  IDCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class IDCommentGenerator: CommentGenerator {
    func convertComment(in string: String, with result: [NSTextCheckingResult]) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.count)
        return validation ?? ValidationComment(comment: "사용 가능한 아이디입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: Int) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result)
        return validation ?? ValidationComment(comment: "사용 가능한 아이디입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSRange) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.length)
        return validation ?? ValidationComment(comment: "사용 가능한 아이디입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSTextCheckingResult?) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result?.range.length ?? 0)
        return validation ?? ValidationComment(comment: "사용 가능한 아이디입니다.", commentColor: .green)
    }
    
    private func generateValidation(in string: String, matchingCount: Int) -> ValidationComment? {
        if string.count > 20 && string.count < 5 {
            return ValidationComment(comment: "5~20자 내의 ID만 사용 가능합니다.", commentColor: .red)
        }
        
        if matchingCount > 0 {
            return ValidationComment(comment: "소문자, 숫자, 특수기호(_)(-)만 사용 가능합니다.", commentColor: .red)
        }
        
        return nil
    }
}
