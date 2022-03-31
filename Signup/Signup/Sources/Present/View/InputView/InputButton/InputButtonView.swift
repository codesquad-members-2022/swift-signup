//
//  InputButtonView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import UIKit
import Combine

class InputButtonView: InputView, InputButtonField {
    
    private let message: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray200.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    var publisher: AnyPublisher<Void, Never> {
        button.publisher(for: .touchUpInside)
    }
    
    override init() {
        super.init()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout() {
        self.optionView.addSubview(message)
        message.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        message.leadingAnchor.constraint(equalTo: optionView.leadingAnchor, constant: 10).isActive = true
        message.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        message.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
        
        self.optionView.addSubview(button)
        button.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
    }
    
    func setMessage(_ message: String) {
        self.message.text = message
    }
}
