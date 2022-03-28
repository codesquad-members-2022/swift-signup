//
//  SignUpRepository.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

protocol SignUpRepository {
    func signUp(userId: String, password: String) -> AnyPublisher<Response<ResponseResult>, Error>
}
