//
//  UISegmentedControl+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation
import UIKit
import Combine

extension UISegmentedControl {
    func publisher() -> AnyPublisher<Int, Never> {
        EventPublisher<Int>(control: self, event: .valueChanged, receiveClosure: {
            self.selectedSegmentIndex
        }).eraseToAnyPublisher()
    }
}
