//
//  TextFieldDelegate.swift
//  SignupApp
//
//  Created by 김동준 on 2022/04/03.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject{
    private var workItem: DispatchWorkItem?
    private let delay = 0.5
    
    @objc func editChanged(textField: UITextField){
        self.workItem?.cancel()
        let workItem = DispatchWorkItem(block: {
            guard let text = textField.text else { return }
            
            let idFieldType = IDTextField.self
            let passwordFieldType = PasswordTextField.self
            let passwordCheckFieldType = PasswordCheckTextField.self
            let nameFieldType = NameTextField.self
            
            if type(of: textField) == idFieldType{
                guard let textField = textField as? IDTextField else { return }
                textField.editedChangeTextField(text: text)
            }
            
            if type(of: textField) == passwordFieldType{
                guard let textField = textField as? PasswordTextField else { return }
                textField.editedChangeTextField(text: text)
            }
            
            if type(of: textField) == passwordCheckFieldType{
                guard let textField = textField as? PasswordCheckTextField else { return }
                textField.editedChangeTextField(text: text)
            }
            
            if type(of: textField) == nameFieldType{
                guard let textField = textField as? NameTextField else { return }
                textField.editedChangeTextField(text: text)
            }
        })
        self.workItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
    }
}

extension TextFieldDelegate: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(editChanged), for: .editingChanged)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.removeTarget(self, action: #selector(editChanged), for: .editingChanged)
    }
}
