//
//  CustomButton.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

/// 버튼의 내부 라벨, 상태, 내용 등을 관리한다.
final class CustomSegueButton: UIButton {
    
    // MARK: - Local Properties
    
    private(set) var arrowImageDirection: ButtonArrow = .right
    private var buttonTitle: String = "titleNone"
    
    // MARK: - Initializers
    
    convenience init(with frame: CGRect, as title: String, using selector: Selector, direction: ButtonArrow = .right) {
        self.init(frame: frame)
        buttonTitle = title
        arrowImageDirection = direction
        addTarget(superview, action: selector, for: .touchUpInside)
        resetButtonViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        resetButtonViews()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        resetButtonViews()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.textAlignment = .center
    }
    
    // MARK: - Utility in CustomSegueButton
    
    func changeArrowDirection() {
        arrowImageDirection = arrowImageDirection == .left ? .right : .left
        setImage(arrowImageDirection.convertUIImageView(), for: .normal)
    }
    
    func changeTitle(in title: String) {
        buttonTitle = title
        setTitle(title, for: .normal)
    }
    
    private func resetButtonViews() {
        setImage(arrowImageDirection.convertUIImageView(), for: .normal)
        setTitle(buttonTitle, for: .normal)
        titleLabel?.frame.size.width = self.frame.width - (imageView?.frame.maxX ?? 0)
        setTitleColor(.tintColor, for: .normal)
        backgroundColor = .systemGray5
    }
    
    // MARK: - Arrow Image Type
    
    enum ButtonArrow: String {
        case left = "arrow.left.circle"
        case right = "arrow.right.circle"
        
        func convertUIImageView() -> UIImage? {
            UIImage(systemName: self.rawValue)
        }
    }
}
