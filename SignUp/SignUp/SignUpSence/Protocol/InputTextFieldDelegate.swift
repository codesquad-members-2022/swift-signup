//
//  InputTextFieldDelegate.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import UIKit

protocol InputTextFieldDelegate {
    func textFieldEndEditing(inputViewID:String, textField:UITextField)
}
