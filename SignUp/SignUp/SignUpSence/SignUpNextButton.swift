//
//  SignUpNextButton.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

class SignUpNextButton:UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        var config = UIButton.Configuration.plain()
        config.title = "다음"
        config.image = UIImage(systemName: "chevron.right.square.fill")
        config.imagePlacement = .leading
        config.baseBackgroundColor = .systemGray
        config.buttonSize = .large
        self.configuration = config
    }
    
    
}


