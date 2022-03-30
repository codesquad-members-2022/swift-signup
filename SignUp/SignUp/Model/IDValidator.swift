//
//  IDValidator.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import Foundation

struct IDValidator: Validatable {
    func validate(of text: String) -> Result<Bool, Error> {
        let lackOfLetterValidateRegex = #".{5,}"#
        let muchOfLetterValidateRegex = #".{21,}"#
        let invalidSymbolValidateRegex = #"[^-_a-z0-9]."#
        let finalValidateRegex = #"[a-z0-9-_]{5,20}"#
        
        if text.range(of: lackOfLetterValidateRegex, options: .regularExpression) == nil {
            return .failure(IDValidateError.lackOfLetter)
        }
        
        if text.range(of: muchOfLetterValidateRegex, options: .regularExpression) != nil {
            return .failure(IDValidateError.muchOfLetter)
        }
        
        if text.range(of: invalidSymbolValidateRegex, options: .regularExpression) != nil {
            return .failure(IDValidateError.invalidSymbol)
        }
        
        if text.range(of: finalValidateRegex, options: .regularExpression) != nil {
            return .success(true)
        }
        
        return .failure(IDValidateError.unknownError)
    }
}

enum IDValidateError: Error {
    case lackOfLetter
    case muchOfLetter
    case invalidSymbol
    case unknownError
}
