//
//  SignUpViewModel.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

class SignUpModel {
    
    struct Action {
        let userIdEntered = PassthroughSubject<String, Never>()
        let passwordEntered = PassthroughSubject<String, Never>()
        let nextButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    let signUpRespository: SignUpRepository = SignUpRepositoryImpl()
    
    init() {
        let userIdAndPassword = Publishers
            .CombineLatest(action.userIdEntered, action.passwordEntered)
        
        let requestLogin = self.action.nextButtonTapped
            .combineLatest(action.userIdEntered, action.passwordEntered)
            .filter { _, userId, password in
                var inputData = true
                if userId.isEmpty {
                    inputData = false
                }

                if password.isEmpty {
                    inputData = false
                }

                return inputData
            }
            .map { _, userId, password -> AnyPublisher<Response<testModel>, Error> in
                self.signUpRespository.signUp(userId: userId, password: password)
            }.share()
        
        requestLogin
            .switchToLatest()
            .sink(receiveCompletion: { data in
                print("asdfasfasfasfdwdsf233434")
            }, receiveValue: { data in
                print("성공했따고??")
            }).store(in: &cancellables)
    }
    
    private func checkResponse(_ response: URLResponse?) -> ResponseError? {
        if let response = response as? HTTPURLResponse,
           (200..<300).contains(response.statusCode) == false {
            return ResponseError.statusCode(response)
        }
        return nil
    }
    enum ResponseError: Error {
        case statusCode(HTTPURLResponse)
    }
}

struct testModel: Decodable {
    let result: String
    let status: String
}


enum testAPI {
    
}
