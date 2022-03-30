//
//  SignUpNetwork.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/29.
//
typealias UserID = [String]

import Foundation

final class SignUpNetwork {
    
    private var config = URLSessionConfiguration.default
    private var session = URLSession(configuration:.default)
    
    var delegate:SignUpNetworkDelegate?
    
    func getID() {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else { return }
            guard let response = response,
                  let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else { return }
                  
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(UserID.self, from: data) else { return }
            self.delegate?.didFetchUserID(userInfo: userInfo)
        }
        .resume()
    }
    
    func postRequest(body:PostMessage) {
        guard let signUpURL = URL(string:"https://api.codesquad.kr/signup") else { return }
        guard let requestBody = try? JSONEncoder().encode(body) else { return }
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else { return }
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(PostResult.self, from: data) else { return }
            print(result)
        }
        .resume()
    }
    
    func session(_ urlSession: URLSession) {
        self.session = urlSession
    }
}




