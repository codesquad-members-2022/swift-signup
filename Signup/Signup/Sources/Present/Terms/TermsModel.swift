//
//  TermsModel.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation
import Combine

class TermsModel {
    struct Action {
        let loadTermsText = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let loadedTermsText = PassthroughSubject<String, Never>()
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    init() {
        action.loadTermsText
            .map {
                if let filePath = Bundle.main.path(forResource: "termsText", ofType: "txt"),
                   let termsText = try? String(contentsOfFile: filePath) {
                    return termsText
                } else {
                    return ""
                }
            }
            .sink(receiveValue: self.state.loadedTermsText.send(_:))
            .store(in: &cancellables)
    }
}
