//
//  InputTextField.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import Combine
import UIKit

protocol InputTextField {
    var textPublisher: AnyPublisher<String, Never> { get }
    var title: String { get }
    var placeholder: String { get }
    var isSecureTextEntry: Bool { get }
    var textContentType: UITextContentType { get }
    var view: UIView { get }
    func setSubMessage(_ isError: Bool, _ message: String)
}
