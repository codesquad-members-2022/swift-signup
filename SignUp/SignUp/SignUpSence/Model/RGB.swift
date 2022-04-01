//
//  RGB.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//


final class RGB{
    
    static let minValue: Int = 0
    static let maxValue: Int = 255
    
    static let green:RGB = RGB(red: 0, green: 255, blue: 0)
    static let red:RGB = RGB(red: 255, green: 0, blue: 0)
    
    private var inputRedValue:Int
    private var inputGreenValue:Int
    private var inputBlueValue:Int
    
    var red:Int { self.translateInputRGBValue(inputValue: inputRedValue) }
    var green:Int { self.translateInputRGBValue(inputValue: inputGreenValue) }
    var blue:Int { self.translateInputRGBValue(inputValue: inputBlueValue) }
    
    init(red:Int,green:Int,blue:Int) {
        self.inputRedValue = red
        self.inputGreenValue = green
        self.inputBlueValue = blue
    }
    
    private func translateInputRGBValue(inputValue:Int) -> Int{
        
        if inputValue < RGB.minValue {
            return RGB.minValue
        } else if inputValue > RGB.maxValue {
            return RGB.maxValue
        } else {
            return inputValue
        }
        
    }
}
