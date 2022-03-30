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
    
    
    func getRequest<T:Decodable>(completion:@escaping (Result<T,SignUpNetworkError>) -> Void) {
        //is URL available?
        guard let signUpURL = signUpURL else { return }
        
        var urlRequest = URLRequest(url: signUpURL)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, _ in
            guard let self = self else { return }
            guard let data = data, self.isResponseClear(response: response) == true
            else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
                }
            
            catch {
                completion(.failure(.decodingError))
            }
        }
        
        dataTask.resume()
    }
    
    func postRequest<T:Decodable>(postBody:UserInfo, completion: @escaping((Result<T,SignUpNetworkError>) -> Void)) {
        //is URL available?
        guard let signUpURL = signUpURL else { return }
        var urlRequest = URLRequest(url: signUpURL)
        urlRequest.httpMethod = "POST"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(postBody)
            
            //is response clear?
            let dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, _ in
                    guard let self = self else { return }
                    guard let data = data, self.isResponseClear(response: response) == true
                    else {
                    completion(.failure(.responseError))
                    return
                }
            
                do {
                    //then decode
                    let messageData = try JSONDecoder().decode(T.self, from: data)
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
    
    func url(_ url:URL) {
        self.signUpURL = url
    }
    
    private func isResponseClear(response:URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else { return false }
        if (200..<300) ~= httpResponse.statusCode {
            return true
        } else {
            return false
        }
    }
}


enum httepMethod:String {
    case get = "GET"
    case post = "POST"
}



/*
 var request = URLRequest(url: signUpURL)
 request.httpMethod = "GET"
 
 let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
     guard let self = self else { return }
     guard let data = data else { return }
     guard let response = response,
           let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else { return }
           
     let decoder = JSONDecoder()
     guard let userInfo = try? decoder.decode(UserID.self, from: data) else { return }
     
 }
 .resume()
 */
