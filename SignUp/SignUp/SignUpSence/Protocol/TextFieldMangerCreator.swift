//
//  TextFieldMangerCreator.swift
//  SignUp
//
//  Created by 박진섭 on 2022/04/01.
//

protocol TextFieldMangerCreator {
    func makeTextFieldManger(id:inputViewIdentifierable) -> SignUpInputViewTextFieldMangerable
}
