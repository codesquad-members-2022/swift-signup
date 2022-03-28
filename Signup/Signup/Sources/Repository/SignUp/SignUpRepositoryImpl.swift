//
//  SignUpRepositoryImpl.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

class SignUpRepositoryImpl: NetworkRepository<SignUpTarget>, SignUpRepository {
    func signUp(userId: String, password: String) -> AnyPublisher<Response<testModel>, Error> {
        request(.signUp(userId: userId, password: password))
    }
}
