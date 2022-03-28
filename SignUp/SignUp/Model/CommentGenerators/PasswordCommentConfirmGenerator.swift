//
//  PasswordCommentConfirmGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class PasswordCommentConfirmGenerator: CommentGenerator {
    func convertComment(in string: String, with result: [NSTextCheckingResult]) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.count)
        return validation ?? ValidationComment(comment: "비밀번호가 일치합니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: Int) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result)
        return validation ?? ValidationComment(comment: "비밀번호가 일치합니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSRange) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.length)
        return validation ?? ValidationComment(comment: "비밀번호가 일치합니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSTextCheckingResult?) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result?.range.length ?? 0)
        return validation ?? ValidationComment(comment: "비밀번호가 일치합니다.", commentColor: .green)
    }
    
    private func generateValidation(in string: String, matchingCount: Int) -> ValidationComment? {
        if matchingCount != 1 {
            return ValidationComment(comment: "비밀번호가 일치하지 않습니다.", commentColor: .red)
        }
        
        return nil
    }
}
