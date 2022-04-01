//
//  TextFieldValueChecker.swift
//  Signup
//
//  Created by juntaek.oh on 2022/03/30.
//

import Foundation
import os

class TextFieldValueChecker{
    private var jsonFactory: JSONConverter
    
    init(){
        self.jsonFactory = JSONConverter()
        NetworkConnector.respondeGET(url: "https://api.codesquad.kr/signup"){ data in
            self.jsonFactory.convertExistIdData(data: data)
        }
    }
    
    func checkValidationOfID(text: String) -> CheckValidIDCase{
        let pattern: String = "^[0-9a-z_-]*$"
        
        guard text.range(of: pattern, options: .regularExpression) != nil else{
            return .invalid
        }
        
        if text.count < 4{
            return .shortLength
        } else if text.count > 20{
            return .longLength
        } else{
            let test = jsonFactory.existIds.filter{ $0 == text}
            
            if test.isEmpty{
                return .valid
            } else{
                return .usedId
            }
        }
    }
    
    func checkValidationOfPsw(text: String) -> CheckValidPswCase{
        let fullPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}$"
        let fullPred = NSPredicate(format: "SELF MATCHES %@", fullPattern)
        
        let upperPattern = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%]).{8,16}$"
        let upperPred = NSPredicate(format: "SELF MATCHES %@", upperPattern)
        
        let numberPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%]).{8,16}$"
        let numberPred = NSPredicate(format: "SELF MATCHES %@", numberPattern)
        
        let specialPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,16}$"
        let specialPred = NSPredicate(format: "SELF MATCHES %@", specialPattern)
        
        guard !fullPred.evaluate(with: text) else{
            return .valid
        }

        if text.count < 8{
            return .shortLegth
        } else if text.count > 16{
            return .longLength
        } else if upperPred.evaluate(with: text){
            return .noUpperCase
        } else if numberPred.evaluate(with: text){
            return .noNumber
        } else if specialPred.evaluate(with: text){
            return .noSpecialChar
        } else{
            return .invalid
        }
    }
}
