//
//  Date+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation

extension Date {
    func addYear(_ year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        return Calendar.current.date(byAdding: dateComponents, to: self)
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
