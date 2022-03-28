//
//  PasswordCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class PasswordCommentGenerator: CommentGenerator {
    func convertComment(in string: String, with result: [NSTextCheckingResult]) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.count)
        return validation ?? ValidationComment(comment: "안전한 비밀번호입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: Int) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result)
        return validation ?? ValidationComment(comment: "안전한 비밀번호입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSRange) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.length)
        return validation ?? ValidationComment(comment: "안전한 비밀번호입니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSTextCheckingResult?) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result?.range.length ?? 0)
        return validation ?? ValidationComment(comment: "안전한 비밀번호입니다.", commentColor: .green)
    }
    
    private func generateValidation(in string: String, matchingCount: Int) -> ValidationComment? {
        if string.count > 16 && string.count < 8 {
            return ValidationComment(comment: "8~16자 내의 비밀번호만 사용 가능합니다.", commentColor: .red)
        }
        
        if matchingCount < 2 {
            return ValidationComment(comment: "소문자, 특수문자를 최소 1자 이상 포함해주시기 바랍니다.", commentColor: .red)
        }
        
        return nil
    }
}
