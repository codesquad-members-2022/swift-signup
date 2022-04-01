//
//  InputTextFieldDelegate.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/30.
//

import UIKit

protocol SignUpInputTextFieldDelegate {
    func textFieldEndEditing(inputViewID:inputViewIdentifierable, textField:UITextField)
}
