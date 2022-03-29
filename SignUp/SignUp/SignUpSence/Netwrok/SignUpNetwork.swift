//
//  SignUpNetwork.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/29.
//
typealias UserID = [String]

import Foundation

final class SignUpNetwork {
    
    private let successRange = 200..<300
    private let config = URLSessionConfiguration.default
    private let session = URLSession(configuration:.default)
    
    var delegate:SignUpNetworkDelegate?
    
    func requestID() {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else { return }
            guard let response = response,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  self.successRange.contains(statusCode)
                  else { return }
            
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(UserID.self, from: data) else { return }
            self.delegate?.didFetchUserID(userInfo: userInfo)
        }
        .resume()
    }
    
    
    func postRequest(body:String) {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        guard let body = body.data(using: .utf8) else { return }
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"

        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else {return }
            guard let data = data else { return }
            guard let response = response,let status = (response as? HTTPURLResponse)?.statusCode, self.successRange.contains(status) else { return }
            guard error != nil else {

                return
            }

        }
    }
}




