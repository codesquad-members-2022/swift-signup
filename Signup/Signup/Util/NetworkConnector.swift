//
//  NetworkConnector.swift
//  Signup
//
//  Created by juntaek.oh on 2022/04/01.
//

import Foundation
import os

class NetworkConnector{
    static func respondeGET(url: String, decoder: @escaping (Data) -> ()){
        guard let rightURL = URL(string: url) else { return }
        
        var request = URLRequest(url: rightURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {
                os_log("No data in here")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                os_log("URLResponse is wrong")
                return
            }
            
            decoder(data)
        }.resume()
    }
}
