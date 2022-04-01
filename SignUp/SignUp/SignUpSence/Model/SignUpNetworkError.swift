//
//  SignUpNetworkError.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

enum SignUpNetworkError:Error {
    case decodingError
    case encodingError
    case responseError
    case otherError
}
