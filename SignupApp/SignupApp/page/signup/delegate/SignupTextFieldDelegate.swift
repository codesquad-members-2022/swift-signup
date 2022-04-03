//
//  SignupTextFieldDelegate.swift
//  SignupApp
//
//  Created by 김동준 on 2022/03/28.
//

import Foundation

protocol SignupTextFieldDelegate{
    //func editedIdTextField(id: String)
    //func editedPasswordTextField(password: String)
    //func editedPasswordCheckTextField(passwordCheck: String)
    //func editedNameTextField(name: String)
}

protocol InputableDelegate{
    func editedChangeTextField(text: String)
}

protocol IDInputable: InputableDelegate{
    func editedIdTextField(id: String)
}

protocol PasswordInputable: InputableDelegate{
    func editedPasswordTextField(password: String)
}

protocol PasswordCheckInputable: InputableDelegate{
    func editedPasswordCheckTextField(passwordCheck: String)
}

protocol NameInputable: InputableDelegate{
    func editedNameTextField(name: String)
}

protocol SignupInputDelegate: IDInputable, PasswordInputable, PasswordCheckInputable, NameInputable{
    
}
