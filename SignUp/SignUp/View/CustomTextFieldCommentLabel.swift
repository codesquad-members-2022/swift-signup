//
//  CustomTextFieldCommentLabel.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

typealias CustomTextFieldTextState = CustomTextFieldCommentLabel.State

class CustomTextFieldCommentLabel: UILabel {
    
    private(set) var currentState = State.none
    private var comments: Dictionary<State, String>?
    
    convenience init(with frame: CGRect, messageHandler: ([State])->Dictionary<State, String>) {
        self.init(frame: frame)
        self.comments = messageHandler(State.allCases)
    }
    
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
    
    func showComment(state: State? = nil) {
        if let state = state {
            self.currentState = state
        }
        
        let text = getCurrentComment()
        self.text = text
        self.textColor = getCommentColor()
    }
    
    func hideComment() {
        self.text = ""
    }
    
    private func getCurrentComment() -> String {
        return comments?[currentState] ?? ""
    }
    
    private func getCommentColor() -> UIColor {
        switch currentState {
        case .none:
            return UIColor.clear
        case .correct:
            return UIColor.systemGreen
        case .warning:
            return UIColor.systemRed
        case .disable:
            return UIColor.lightGray
        }
    }
    
    enum State: String, CaseIterable, Hashable {
        case none = "none"
        case correct = "correct"
        case warning = "warning"
        case disable = "disable"
    }
}
