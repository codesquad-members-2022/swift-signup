//
//  EmailCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class EmailCommentGenerator: CommentGenerator {
    func convertComment(in string: String, with result: [NSTextCheckingResult]) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.count)
        return validation ?? ValidationComment(comment: "이메일 형식에 이상이 없습니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: Int) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result)
        return validation ?? ValidationComment(comment: "이메일 형식에 이상이 없습니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSRange) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result.length)
        return validation ?? ValidationComment(comment: "이메일 형식에 이상이 없습니다.", commentColor: .green)
    }
    
    func convertComment(in string: String, with result: NSTextCheckingResult?) -> ValidationComment {
        let validation = generateValidation(in: string, matchingCount: result?.range.length ?? 0)
        return validation ?? ValidationComment(comment: "이메일 형식에 이상이 없습니다.", commentColor: .green)
    }
    
    private func generateValidation(in string: String, matchingCount: Int) -> ValidationComment? {
        if matchingCount == 3 {
            return ValidationComment(comment: "이메일 형식이 맞지 않습니다.", commentColor: .red)
        }
        
        return nil
    }
}
