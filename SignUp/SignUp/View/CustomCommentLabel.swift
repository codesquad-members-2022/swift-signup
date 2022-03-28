//
//  CustomCommentLabel.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

typealias CommentColor = CustomCommentLabel.CommentColor

class CustomCommentLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.height = 0
        self.frame.origin.y = self.frame.height + self.frame.maxY
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame.size.height = 0
        self.frame.origin.y = self.frame.height + self.frame.maxY
    }
    
    func showComment(_ valicationComment: ValidationComment?) {
        self.text = valicationComment?.comment
        self.textColor = valicationComment?.commentColor.getCommentColor()
        self.sizeToFit()
    }
    
    func hideComment() {
        self.text = ""
        self.frame.size.height
    }
    
    enum CommentColor {
        case red
        case green
        case gray
        
        func getCommentColor() -> UIColor {
            switch self {
            case .red:
                return UIColor.systemRed
            case .green:
                return UIColor.systemGreen
            case .gray:
                return UIColor.systemGray5
            }
        }
    }
}
