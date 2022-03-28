//
//  NetworkRepository.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

class NetworkRepository<T: BaseTarget> {
    func request<T1: Decodable>(_ target: T) -> AnyPublisher<Response<T1>, Error> {
        var url = target.baseURL
        url = url.appendingPathComponent(target.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method
        
        if let param = target.parameter,
           let body = try? JSONSerialization.data(withJSONObject: param, options: .init()) {
            urlRequest.httpBody = body
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { result in
                let value = try JSONDecoder().decode(T1.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
