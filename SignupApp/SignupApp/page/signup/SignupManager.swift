//
//  SignupManager.swift
//  SignupApp
//
//  Created by 김동준 on 2022/03/28.
//

import Foundation
import UIKit


class SignupManager{
    private let signupNetworkUsable: SignupNetworkUsable
    private let regularExpressionCheck: SignupExpressionCheckable
    
    init(signupNetworkUsable: SignupNetworkUsable, signupExpressionCheckable :SignupExpressionCheckable){
        self.signupNetworkUsable = signupNetworkUsable
        self.regularExpressionCheck = signupExpressionCheckable
        
        NotificationCenter.default.addObserver(self, selector: #selector(idChanged), name: UITextField.Notification.Event.editedID, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordChanged), name: UITextField.Notification.Event.editedPassword, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordCheckChanged), name: UITextField.Notification.Event.editedPasswordCheck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nameChanged), name: UITextField.Notification.Event.editedName, object: nil)
    }
    
    @objc private func idChanged(noti: Notification){
        guard let id = noti.userInfo?[UITextField.Notification.Key.id] as? String else { return }
        verifyUsableId(id: id)
    }
    
    @objc private func passwordChanged(noti: Notification){
        guard let password = noti.userInfo?[UITextField.Notification.Key.password] as? String else { return }
        verifyPassword(password: password)
    }
    
    @objc private func passwordCheckChanged(noti: Notification){
        guard let passwordCheck = noti.userInfo?[UITextField.Notification.Key.passwordCheck] as? String else { return }
        
    }
    
    @objc private func nameChanged(noti: Notification){
        guard let name = noti.userInfo?[UITextField.Notification.Key.name] as? String else { return }
    
    }
    
    private func verifyUsableId(id: String){
       regularExpressionCheck.verifyUsableId(id: id)
    }
    
    private func verifyUsablePassword(password: String){
       regularExpressionCheck.verifyUsablePassword(password: password)
    }
    
    private func checkPasswordSame(password: String){
        
    }
    
    private func nameSave(name: String){
        
    }
    
    
}

extension SignupManager: SignManagable{
    func isNilName(name: String) {
        
    }
    
    func verifyid(id: String) {
        verifyUsableId(id: id)
    }
    
    func verifyPassword(password: String) {
        verifyUsablePassword(password: password)
    }
    
    func verifyPasswordCheck(password: String) {
        
    }
    
}
