//
//  InputSegmented.swift
//  Signup
//
//  Created by seongha shin on 2022/03/30.
//

import Foundation
import UIKit
import Combine

protocol InputSegmented {
    var publisher: AnyPublisher<Int, Never> { get }
    var view: UIView { get }
}
