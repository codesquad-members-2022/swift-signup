//
//  CustomButton.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import UIKit

class CustomButton: UIButton {
    
    init(frame: CGRect, systemImageName: String = "arrowtriangle.right.circle.fill", title: String) {
        super.init(frame: frame)
        let fixedColor = UIColor(red: 0.35030133279999998, green: 0.81205902640000005, blue: 0.91972458960000003, alpha: 1)
        
        let buttonImageConfiguration = UIImage.SymbolConfiguration.init(hierarchicalColor: fixedColor)
        self.setImage(UIImage(systemName: systemImageName, withConfiguration: buttonImageConfiguration), for: .normal)
        self.backgroundColor = .white
        self.semanticContentAttribute = .forceLeftToRight
        self.setTitle(title, for: .normal)
        self.setTitleColor(fixedColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.imageView?.image = UIImage()
        self.setTitle(" ", for: .normal)
    }
}
