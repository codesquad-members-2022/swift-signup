//
//  String+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation

extension String {
    //format에 있는 값만 사용하고 있는지?
    func validatePredicate(format: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: self)
    }
    
    //pattern에 있는 값을 사용했는지?
    func vaildateRegex(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return !results.isEmpty
    }
}
