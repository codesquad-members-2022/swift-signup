//
//  CustomButton.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

/// 버튼의 내부 라벨, 상태, 내용 등을 관리한다.
class CustomSegueButton: UIButton {
    
    private var arrowDirection: ButtonArrow = .right
    private var buttonTitle: String = "titleNone"
    
    convenience init(with frame: CGRect, as title: String, using selector: Selector, direction: ButtonArrow = .right) {
        self.init(frame: frame)
        self.buttonTitle = title
        addTarget(superview, action: selector, for: .touchUpInside)
        (self.subviews.first(where: {v in v is UILabel}) as? UILabel)?.text = buttonTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let leftPadding = frame.width/6
        let imageView = setArrowImageView(direction: .right, as: leftPadding)
        setNameLabel(maskingView: imageView, as: leftPadding, using: buttonTitle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let leftPadding = frame.width/6
        let imageView = setArrowImageView(direction: .right, as: leftPadding)
        setNameLabel(maskingView: imageView, as: leftPadding, using: buttonTitle)
    }
    
    @discardableResult
    func setArrowImageView(direction: ButtonArrow, as padding: CGFloat) -> UIImageView {
        let imageView = direction.convertUIImageView()
        addSubview(imageView)
        imageView.center.y = self.center.y
        imageView.frame.origin.x = padding
        return imageView
    }
    
    @discardableResult
    func setNameLabel(maskingView: UIView, as padding: CGFloat, using title: String) -> UILabel {
        let label = UILabel()
        addSubview(label)
        label.text = title
        label.center.y = self.center.y
        label.frame = CGRect(
            x: maskingView.frame.maxX + padding/2,
            y: self.center.y - maskingView.frame.height/2,
            width: self.frame.width - maskingView.frame.maxX + padding/2,
            height: maskingView.frame.height
        )
        label.textColor = .tintColor
        return label
    }
    
    enum ButtonArrow: String {
        case left = "arrow.left.circle"
        case right = "arrow.right.circle"
        
        func convertUIImageView() -> UIImageView {
            UIImageView(image: UIImage(systemName: self.rawValue))
        }
    }
}
