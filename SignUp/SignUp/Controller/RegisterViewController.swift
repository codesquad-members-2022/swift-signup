//
//  RegisterViewController.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {
    static let identifier = "RegisterViewController"
    
    private var inputComponentsViewStack: UIStackView?
    private var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInputComponentsViewStack()
        configureNextButton()
    }
    
    private func configureInputComponentsViewStack() {
        self.inputComponentsViewStack = UIStackView()
        guard let inputComponentsViewStack = inputComponentsViewStack else {
            return
        }

        inputComponentsViewStack.axis = .vertical
        inputComponentsViewStack.distribution = .fillEqually
        
        let inputComponentsViews = generateInputComponentsView()
        
        inputComponentsViews.forEach {
            inputComponentsViewStack.addArrangedSubview($0)
        }
        
        self.view.addSubview(inputComponentsViewStack)
        
        inputComponentsViewStack.translatesAutoresizingMaskIntoConstraints = false
        
        let space: CGFloat = UIScreen.main.bounds.width / 10
        let safeArea = self.view.safeAreaLayoutGuide

        inputComponentsViewStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: space).isActive = true
        inputComponentsViewStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 2.5 * space).isActive = true
        inputComponentsViewStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -space).isActive = true
        inputComponentsViewStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10 * space).isActive = true
    }
    
    private func configureNextButton() {
        self.nextButton = ViewFactory.makeCustomButton(title: "다음")
        guard let nextButton = nextButton,
              let inputComponentsViewStack = inputComponentsViewStack else {
            return
        }

        self.view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        let space: CGFloat = UIScreen.main.bounds.width/5
        let safeArea = self.view.safeAreaLayoutGuide
        
        nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 2.1 * space).isActive = true
        nextButton.topAnchor.constraint(equalTo: inputComponentsViewStack.bottomAnchor, constant:  0.7 * space).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -2.1 * space).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -3.8 * space).isActive = true
    }
    
    private func generateInputComponentsView() -> [InputComponentsViewable] {
        let titlePlaceholderMap = ["아이디": "영문 소문자, 숫자, 특수기호(_,-), 5~20자", "비밀번호": "영문 대/소문자, 숫자,. 특수문자(!@#$%) 8~16자", "비밀번호 재확인": "", "이름": ""]
        let keys = ["아이디", "비밀번호", "비밀번호 재확인", "이름"]
        var inputComponentsViews = [InputComponentsViewable]()
        
        for key in keys {
            let newInputComponentsView = ViewFactory.makeInputComponentsView(title: key, placeholder: titlePlaceholderMap[key] ?? "")
            inputComponentsViews.append(newInputComponentsView)
        }
        
        return inputComponentsViews
    }
}
