//
//  PasswordCommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class PasswordValidationResult: ValidationResult {
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
    }
    
    func commentRepresentation(in string: String) -> String {
        switch state {
        case .good:
            return "안전한 비밀번호입니다."
        case .bad:
            if string.count > 16 || string.count < 8 {
                return "8자 이상 16자 이하로 입력해주세요."
            }
            
            var spottedString = ""
            var stringSet = Set.init(string)
            for result in validateResult {
                spottedString += string[string.index(string.startIndex, offsetBy: result.range.lowerBound)..<string.index(string.startIndex, offsetBy: result.range.upperBound)]
            }
            for char in spottedString {
                stringSet.remove(char)
            }
            
            var result = ""
            
            guard stringSet.count != 0 else {
                return "영문 대문자, 숫자, 특수문자를 최소 1자 이상 포함해주세요."
            }
            
            if stringSet.contains(where: {char in char.isUppercase}) == false {
                result += "영문 대문자"
            }
            
            if stringSet.contains(where: {char in char.isNumber}) == false {
                result += "\(result.count > 0 ? ", " : "")숫자"
            }
            
            if stringSet.filter({char in char.isWhitespace || char.isPunctuation || char.isCurrencySymbol}).count == 0 { // 공백, 느낌을 나타내는 ! 등의 문자, 통화(돈) 관련 문자
                result += "\(result.count > 0 ? ", " : "")특수문자"
            }
            
            if result.count > 0 {
                state = .bad
                result += "를 최소 1자 이상 포함해주세요."
            } else {
                state = .good
                return commentRepresentation(in: string)
            }
            
            return result
        }
    }
}
