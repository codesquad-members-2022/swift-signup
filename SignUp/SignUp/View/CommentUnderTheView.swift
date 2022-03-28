//
//  CommentUnderTheView.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit


class CommentUnderTheView: UILabel {
    
    private(set) var currentState = State.none
    private var messages: Dictionary<State, String>?
    
    func getCurrentMessage() -> String {
        return messages?[currentState] ?? ""
    }
    
    convenience init(with frame: CGRect, messageHandler: ([State])->Dictionary<State, String>) {
        self.init(frame: frame)
        self.messages = messageHandler(State.allCases)
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
    
    enum State: String, CaseIterable, Hashable {
        case none = "none"
        case correct = "correct"
        case warning = "warning"
        case disable = "disable"
    }
}
