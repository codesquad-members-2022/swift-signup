//
//  UserInfoViewController.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import UIKit
import Combine

class UserInfoViewController: UIViewController {
    
    let userInfoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개인정보"
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let birthDate: InputButtonField = {
        let buttonView = InputButtonView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.title = "생년월일"
        return buttonView
    }()
    
    let email: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "이메일"
        inputView.textContentType = .emailAddress
        return inputView
    }()
    
    let phoneNumber: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "휴대전화"
        inputView.placeholder = "- 없이 입력해주세요 예)01012341234"
        inputView.textContentType = .telephoneNumber
        return inputView
    }()
    
    let prevButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("이전", for: .normal)
        button.setImage(UIImage(named: "ic_leftArrow")?.withTintColor(.systemGreen), for: .normal)
        button.setImage(UIImage(named: "ic_leftArrow")?.withTintColor(.systemGray2), for: .disabled)
        button.setTitleColor(.systemGreen, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let nextButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("다음", for: .normal)
        button.setImage(UIImage(named: "ic_rightArrow")?.withTintColor(.systemGreen), for: .normal)
        button.setImage(UIImage(named: "ic_rightArrow")?.withTintColor(.systemGray2), for: .disabled)
        button.setTitleColor(.systemGreen, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        return button
    }()
    
    var inputViews: [UIView] {
        [self.birthDate.view, self.email.view, self.phoneNumber.view]
    }
    
    var cancellables = Set<AnyCancellable>()
    
    let model = UserInfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
    }
    
    private func bind() {
        self.birthDate.addAction(UIAction { _ in
            self.model.action.presentDatePickerView.send()
        })
        
        model.state.presentDatePickerView
            .sink(receiveValue: self.showAlertDatePicker(date:))
            .store(in: &cancellables)
        
        model.state.birthDate
            .dropFirst()
            .map { $0?.toString(format: "yyyy-MM-dd") ?? ""}
            .sink(receiveValue: self.birthDate.setMessage(_:))
            .store(in: &cancellables)
        
        self.email.textPublisher
            .sink(receiveValue: self.model.action.emailEntered.send(_:))
            .store(in: &cancellables)
        
        model.state.emailMessage
            .sink(receiveValue: self.email.setSubMessage(_:_:))
            .store(in: &cancellables)
        
        self.phoneNumber.textPublisher
            .sink(receiveValue: self.model.action.phoneNumberEntered.send(_:))
            .store(in: &cancellables)
        
        model.state.phoneNumberMessage
            .sink(receiveValue: self.phoneNumber.setSubMessage(_:_:))
            .store(in: &cancellables)
        
        model.state.isNextButtonEnabled
            .sink { isEnabled in
                self.nextButton.isEnabled = isEnabled
            }.store(in: &cancellables)
        
        prevButton.addAction(UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        }, for: .touchUpInside)
        
        nextButton.addAction(UIAction { _ in
//            self.model.action.nextButtonTapped.send()
        }, for: .touchUpInside)
        
    }
    
    private func attribute() {
        self.view.backgroundColor = .systemGray6
    }
    
    private func layout() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(userInfoTitle)
        userInfoTitle.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        userInfoTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        userInfoTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        userInfoTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: userInfoTitle.bottomAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
        inputViews.forEach { stackView.addArrangedSubview($0)}
        stackView.bottomAnchor.constraint(equalTo: inputViews[inputViews.count - 1].bottomAnchor).isActive = true
        
        self.view.addSubview(prevButton)
        prevButton.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -40).isActive = true
        prevButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        
        self.view.addSubview(nextButton)
        nextButton.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 40).isActive = true
        nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
    }
    
    private func showAlertDatePicker(date: Date) {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.date = date
        datePicker.minimumDate = date.addYear(-(99 - 15))
        datePicker.maximumDate = date.addYear(-15)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.addSubview(datePicker)
        alertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        datePicker.leftAnchor.constraint(equalTo: alertController.view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: alertController.view.rightAnchor).isActive = true
        
        alertController.addAction(UIAlertAction(title: "선택", style: .default){ _ in
            self.model.action.selectBirthDate.send(datePicker.date)
        })
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
