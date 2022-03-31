//
//  Common+String.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

class CommonString {
    //format에 있는 값만 사용하고 있는지?
    static func validatePredicate(_ text: String, format: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: text)
    }
    
    //pattern에 있는 값을 사용했는지?
    static func vaildateRegex(_ text: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return !results.isEmpty
    }
    
    static func vaildateEmail(_ email: String) -> Bool {
        CommonString.validatePredicate(email, format: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$")
    }
    
    static func vaildatePhoneNumber(_ phoneNumber: String) -> Bool {
        CommonString.validatePredicate(phoneNumber, format: "^01([0-9])([0-9]{3,4})([0-9]{4})$")
    }
}
