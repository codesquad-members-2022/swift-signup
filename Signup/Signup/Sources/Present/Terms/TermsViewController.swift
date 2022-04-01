//
//  TermsViewController.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation
import UIKit
import Combine

class TermsViewController: UIViewController {
    
    let termsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개인정보 수집 및 이용에 대한 안내"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let termsText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let cancel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    let agreement: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("동의", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    var cancellables = Set<AnyCancellable>()
    let model = TermsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
        
        self.model.action.loadTermsText.send()
    }
    
    private func bind() {
        self.model.state.loadedTermsText
            .sink {
                self.termsText.text = $0
            }.store(in: &cancellables)
        
        agreement.publisher(for: .touchUpInside)
            .sink {
                
            }.store(in: &cancellables)
        
        cancel.publisher(for: .touchUpInside)
            .sink {
                self.dismiss(animated: true, completion: nil)
            }.store(in: &cancellables)
    }
    
    private func attribute() {
        self.view.backgroundColor = .systemGray6
    }
    
    private func layout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(termsTitle)
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(termsText)
        self.view.addSubview(cancel)
        self.view.addSubview(agreement)
        
        termsTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        termsTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        termsTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -10).isActive = true
        termsTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: termsTitle.bottomAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: agreement.topAnchor, constant: -10).isActive = true
        
        scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor).isActive = true
        scrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leftAnchor).isActive = true
        scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.rightAnchor).isActive = true
        scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 30).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 10).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant:  -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: termsText.bottomAnchor, constant: 10).isActive = true
        
        termsText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:  10).isActive = true
        termsText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:  -10).isActive = true
        termsText.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10).isActive = true
        
        agreement.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        agreement.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -10).isActive = true
        agreement.bottomAnchor.constraint(equalTo: cancel.topAnchor, constant: -10).isActive = true
        agreement.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        cancel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        cancel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -10).isActive = true
        cancel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
