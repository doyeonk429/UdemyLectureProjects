//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by 김도연 on 12/26/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    public mutating func calculateBMI(h height: Float, w weight: Float) {
        let bmiValue = weight / pow(height, 2)
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor.blue)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor.green)
        } else{
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: UIColor.red)
        }
    }
    
    public func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    public func getAdvice() -> String {
        return bmi?.advice ?? "No Advice"
    }
    
    public func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
}
