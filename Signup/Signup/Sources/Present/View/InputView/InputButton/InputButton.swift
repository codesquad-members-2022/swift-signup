//
//  InputButton.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import UIKit

protocol InputButtonField {
    var title: String { get }
    var view: UIView { get }
    func addAction(_ action: UIAction)
    func setMessage(_ message: String)
}
