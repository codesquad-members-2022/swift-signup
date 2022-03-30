//
//  CustomButton.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import UIKit

protocol CustomButtonable: UIButton {
    func setLeftImage(systemName: String)
    func setRightTitle(_ title: String)
}

class CustomButton: UIButton, CustomButtonable {
    
    static let fixedColor = UIColor(red: 0.35030133279999998, green: 0.81205902640000005, blue: 0.91972458960000003, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.semanticContentAttribute = .forceLeftToRight
        self.setTitleColor(CustomButton.fixedColor, for: .normal)
        self.setTitleColor(.systemGray6, for: .disabled)
        self.layer.borderWidth = 1
        self.layer.borderColor = CustomButton.fixedColor.cgColor
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.imageView?.image = UIImage()
        self.setTitle(" ", for: .normal)
    }
    
    func setLeftImage(systemName: String) {
        guard UIImage(systemName: systemName) != nil else {return}
        
        let buttonEnabledConfiguration = UIImage.SymbolConfiguration.init(hierarchicalColor: CustomButton.fixedColor)
        let buttonDisabledConfiguration = UIImage.SymbolConfiguration.init(hierarchicalColor: .systemGray6)
        self.setImage(UIImage(systemName: systemName, withConfiguration: buttonEnabledConfiguration), for: .normal)
        self.setImage(UIImage(systemName: systemName, withConfiguration: buttonDisabledConfiguration), for: .disabled)
    }
    
    func setRightTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }
}
