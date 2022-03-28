//
//  CommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

protocol CommentGenerator {
    func convertComment(in string: String, with result: [NSTextCheckingResult]) -> ValidationComment
    func convertComment(in string: String, with result: Int) -> ValidationComment
    func convertComment(in string: String, with result: NSRange) -> ValidationComment
    func convertComment(in string: String, with result: NSTextCheckingResult?) -> ValidationComment
}

struct ValidationComment {
    let comment: String
    let commentColor: CommentColor
}
