//
//  DebounceableTextField.swift
//  SignupApp
//
//  Created by 김동준 on 2022/03/28.
//

import Foundation
import UIKit

extension UITextField{
    enum Notification{
        enum Key{
            case id
            case password
            case passwordCheck
            case name
        }
        enum Event{
            static let editedID = Foundation.Notification.Name.init("addedRectangle")
            static let editedPassword = Foundation.Notification.Name.init("selectedRectangle")
            static let editedPasswordCheck = Foundation.Notification.Name.init("selectedPhoto")
            static let editedName = Foundation.Notification.Name.init("deselectedCustomView")
        }
    }
}

class IDTextField: UITextField{
    
}
extension IDTextField: InputableDelegate{
    func editedChangeTextField(text: String) {
        NotificationCenter.default.post(name: Notification.Event.editedID, object: self,userInfo: [Notification.Key.id : text])
    }
}

class PasswordTextField: UITextField{
    
}
extension PasswordTextField: InputableDelegate{
    func editedChangeTextField(text: String) {
        NotificationCenter.default.post(name: Notification.Event.editedPassword, object: self,userInfo: [Notification.Key.password : text])
    }
}

class PasswordCheckTextField: UITextField{
    
}
extension PasswordCheckTextField: InputableDelegate{
    func editedChangeTextField(text: String) {
        NotificationCenter.default.post(name: Notification.Event.editedPasswordCheck, object: self, userInfo: [Notification.Key.passwordCheck : text])
    }
}

class NameTextField: UITextField{
    
}
extension NameTextField: InputableDelegate{
    func editedChangeTextField(text: String) {
        NotificationCenter.default.post(name: Notification.Event.editedName, object: self, userInfo: [Notification.Key.name : text])
    }
}
