//
//  Validatable.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import Foundation

protocol Validatable {
    func validate(of text: String) -> Result<Bool, Error>
}
