//
//  InputSegmentedView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/30.
//

import Foundation
import UIKit
import Combine

class InputSegmentedView: InputView, InputSegmented {
    
    var publisher: AnyPublisher<Int, Never> {
        segmentedController.publisher()
    }
    
    private let segmentedController: UISegmentedControl
    
    init(items: [Any], defaultIndex: Int = 0) {
        segmentedController = UISegmentedControl(items: items)
        segmentedController.selectedSegmentIndex = defaultIndex
        super.init()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        segmentedController = UISegmentedControl()
        super.init(coder: coder)
        attribute()
        layout()
    }
    
    private func attribute() {
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.backgroundColor = .gray250
    }
    
    private func layout() {
        self.optionView.addSubview(segmentedController)
        segmentedController.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        segmentedController.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        segmentedController.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        segmentedController.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
    }
}
