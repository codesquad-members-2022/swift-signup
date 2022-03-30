//
//  TextFieldValueChecker.swift
//  Signup
//
//  Created by juntaek.oh on 2022/03/30.
//

import Foundation
import os

class TextFieldValueChecker{
    static let valueChecker = TextFieldValueChecker()
    private var users = [String]()
    
    private init() { }
    
    func checkID(text: String) -> CheckValidIDCase{
        let pattern: String = "^[0-9a-z_-]*$"
        
        guard text.range(of: pattern, options: .regularExpression) != nil else{
            return .invalid
        }
        
        if text.count < 4{
            return .shortLength
        } else if text.count > 20{
            return .longLength
        } else{
            let test = users.filter{ $0 == text}
            
            if test.isEmpty{
                return .valid
            } else{
                return .usedId
            }
        }
    }
    
    func httpGetId(){
        guard let url = URL(string: "https://api.codesquad.kr/signup") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {
                os_log("%@", "\(String(describing: data))")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                os_log("%@", "\(response?.description))")
                return
            }
            
            do{
                let result = try JSONDecoder().decode([String].self, from: data)
                self.users = result
                os_log("%@", "\(self.users)")
            } catch{
                os_log("%@", "\(error)")
                return
            }
        }.resume()
    }
}
