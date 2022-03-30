//
//  SignUpNetwork.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/29.
//
typealias UserID = [String]

import Foundation

final class SignUpNetwork {
    private var signUpURL = URL(string:"https://api.codesquad.kr/signup")
    private var config = URLSessionConfiguration.default
    private var session = URLSession(configuration:.default)
    
    var delegate:SignUpNetworkDelegate?
    
    func getRequest() {
        guard let signUpURL = signUpURL else { return }

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
    
    func postRequest(postBody:PostMessage, completion: @escaping((Result<PostResult,SignUpNetworkError>) -> Void)) {
        
        do {
            //is URL available?
            guard let signUpURL = signUpURL else {
                completion(.failure(.urlError))
                return
            }
            
            var urlRequest = URLRequest(url: signUpURL)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try JSONEncoder().encode(postBody)
            
            //is response clear?
            let dataTask = session.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,(200..<300) ~= httpResponse.statusCode,
                      let data = data else {
                    completion(.failure(.responseError))
                    return
                }
            
                do {
                    //then decode
                    let messageData = try JSONDecoder().decode(PostResult.self, from: data)
                    completion(.success(messageData))
                }
                    //else failure
                catch {
                    completion(.failure(.decodingError))
                }
            }
            dataTask.resume()
        }
        
        catch {
            completion(.failure(.encodingError))
        }
        
    }
    
    func session(_ urlSession: URLSession) {
        self.session = urlSession
    }
    
}
