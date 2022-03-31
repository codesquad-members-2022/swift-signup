//
//  Gender.swift
//  Signup
//
//  Created by seongha shin on 2022/03/30.
//

import Foundation

enum Gender: CaseIterable {
    case female, male
    
    var name: String {
        switch self {
        case .male: return "남자"
        case .female: return "여자"
            
        }
    }
}
