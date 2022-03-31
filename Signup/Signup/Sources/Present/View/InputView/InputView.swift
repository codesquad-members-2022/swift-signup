//
//  InputView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import UIKit
import Combine

class InputView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let optionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    var view: UIView {
        self
    }
    
    var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.addSubview(optionView)
        optionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        optionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        optionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        optionView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.addSubview(subLabel)
        subLabel.topAnchor.constraint(equalTo: optionView.bottomAnchor, constant: 5).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        subLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.bottomAnchor.constraint(equalTo: subLabel.bottomAnchor).isActive = true
    }
}
