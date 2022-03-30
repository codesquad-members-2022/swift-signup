//
//  ViewFactory.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import Foundation

struct ViewFactory {
    static func makeInputComponentsView(title: String, placeholder: String) -> InputComponentsViewable {
        let inputComponentView = InputComponentsView(frame: .zero)
        inputComponentView.setTitle(title)
        inputComponentView.setPlaceholder(placeholder)
        
        return inputComponentView
    }
    
    static func makeCustomButton(title: String, systemImageName: String = "arrowtriangle.right.circle.fill") -> CustomButtonable {
        let customButton = CustomButton(frame: .zero)
        customButton.setLeftImage(systemName: systemImageName)
        customButton.setRightTitle(title)
        
        return customButton
    }
}
