//
//  CustomCommentLabel.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

final class CustomCommentLabel: UILabel {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.height = 0
        self.frame.origin = CGPoint(x: 0, y: frame.height)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame.size.height = 0
    }
    
    // MARK: - Interfaces
    
    func showComment(in string: String, following result: ValidationResult?) {
        self.text = result?.commentRepresentation(in: string)
        
        self.textColor = .tintColor
        if let color = result?.commentColor {
            self.textColor = getCommentColor(from: color)
        }
        
        self.sizeToFit()
    }
    
    func hideComment() {
        self.text = ""
        self.frame.size.height = 0
    }
    
    // MARK: - Nested Types
    
    func getCommentColor(from color: CommentColor) -> UIColor {
        switch color {
        case .red:
            return UIColor.systemRed
        case .green:
            return UIColor.systemGreen
        case .yellow:
            return UIColor.systemYellow
        }
    }
}
