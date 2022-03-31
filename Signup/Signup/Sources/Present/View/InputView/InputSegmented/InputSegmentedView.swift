//
//  InputSegmentedView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/30.
//

import Foundation
import UIKit

class InputSegmentedView: InputView, InputSegmented {
    
    var selectedIndex: Int {
        get {
            segmentedController.selectedSegmentIndex
        }
        set {
            segmentedController.selectedSegmentIndex = newValue
        }
    }
    
    let segmentedController: UISegmentedControl
    
    init(items: [Any]) {
        segmentedController = UISegmentedControl(items: items)
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
        segmentedController.backgroundColor = .systemGray5
    }
    
    private func layout() {
        self.optionView.addSubview(segmentedController)
        segmentedController.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        segmentedController.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        segmentedController.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        segmentedController.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
    }
    
    func addAction(_ action: UIAction) {
        segmentedController.addAction(action, for: .valueChanged)
    }
}
