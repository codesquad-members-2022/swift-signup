//
//  RegisterViewController.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {
    static let identifier = "RegisterViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInputComponentsViewStack()
    }
    
    private func configureInputComponentsViewStack() {
        let inputComponentsViewStack = UIStackView()
        
        inputComponentsViewStack.axis = .vertical
        inputComponentsViewStack.distribution = .fillEqually
        
        inputComponentsViewStack.addArrangedSubview(InputComponentsView(frame: .zero, title: "아이디", placeholder: "영문 소문자, 숫자, 특수기호(_,-), 5~20자"))
        inputComponentsViewStack.addArrangedSubview(InputComponentsView(frame: .zero, title: "비밀번호", placeholder: "영문 대/소문자, 숫자,. 특수문자(!@#$%) 8~16자"))
        inputComponentsViewStack.addArrangedSubview(InputComponentsView(frame: .zero, title: "비밀번호 재확인"))
        inputComponentsViewStack.addArrangedSubview(InputComponentsView(frame: .zero, title: "이름"))
        
        self.view.addSubview(inputComponentsViewStack)
        
        inputComponentsViewStack.translatesAutoresizingMaskIntoConstraints = false
        
        let space: CGFloat = UIScreen.main.bounds.width / 10
        let safeArea = self.view.safeAreaLayoutGuide

        inputComponentsViewStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: space).isActive = true
        inputComponentsViewStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 2.5 * space).isActive = true
        inputComponentsViewStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -space).isActive = true
        inputComponentsViewStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10 * space).isActive = true
    }
}
