//
//  TextField+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map{
                ($0.object as? UITextField)?.text ?? ""
            }
            .eraseToAnyPublisher()
    }
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
