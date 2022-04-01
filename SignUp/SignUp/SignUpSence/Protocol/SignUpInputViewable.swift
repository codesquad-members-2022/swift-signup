//
//  SignUpInputViewable.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

protocol SignUpInputViewable {
    func getTextFieldText() -> String?
    func labelText(text:String)
    func placeholder(text:String)
    func setAlertText(text:String)
    func setIdentifier(id:inputViewIdentifierable)
    func getIdentifier() -> inputViewIdentifierable?
}
