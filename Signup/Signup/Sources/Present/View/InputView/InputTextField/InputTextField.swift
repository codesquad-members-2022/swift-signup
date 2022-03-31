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
    var changedPublisher: AnyPublisher<String, Never> { get }
    var beginEditionPublisher: AnyPublisher<Void, Never> { get }
    var endEditionPublisher: AnyPublisher<Void, Never> { get }
    var view: UIView { get }
    
    func setMessage(_ isError: Bool, _ message: String)
}
