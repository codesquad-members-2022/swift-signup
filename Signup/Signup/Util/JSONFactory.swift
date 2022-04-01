//
//  JSONContainer.swift
//  Signup
//
//  Created by juntaek.oh on 2022/04/01.
//

import Foundation
import os

class JSONFactory{
    private(set) var existIds = [String]()
    
    func convertExistIdData(data: Data){
        do{
            let result = try JSONDecoder().decode([String].self, from: data)
            self.existIds = result
            os_log("%@", "\(String(describing: self.existIds))")
        } catch{
            os_log("%@", "\(error)")
        }
    }
}
