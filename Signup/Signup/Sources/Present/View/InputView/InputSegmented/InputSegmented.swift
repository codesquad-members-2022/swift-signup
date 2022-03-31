//
//  InputSegmented.swift
//  Signup
//
//  Created by seongha shin on 2022/03/30.
//

import Foundation
import UIKit

protocol InputSegmented {
    var view: UIView { get }
    var selectedIndex: Int { get }
    func addAction(_ action: UIAction)
}
