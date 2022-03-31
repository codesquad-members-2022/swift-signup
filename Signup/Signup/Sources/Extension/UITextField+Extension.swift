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
    func changedPublisher() -> AnyPublisher<String, Never> {
        EventPublisher<String>(control: self, event: .editingChanged, receiveClosure: {
            return self.text ?? ""
        }).eraseToAnyPublisher()
    }
    
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
