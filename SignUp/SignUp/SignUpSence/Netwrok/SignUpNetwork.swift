//
//  SignUpNetwork.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/29.
//

import Foundation

final class SignUpNetwork {
    
    static let config = URLSessionConfiguration.default
    static let session = URLSession(configuration:config)
    
    static func getRequest() {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "GET"
        
    }
    
    static func postRequest(body:String) {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
    }
    
}




