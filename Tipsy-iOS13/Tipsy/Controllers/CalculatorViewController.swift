//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButtion: UIButton!
    @IBOutlet weak var tenPctButtion: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10 // 현재 선택된 팁 퍼센트 저장
    var numberOfPeople = 2 // 현재 저장된 n빵 인원 수 저장
    var totalBill: Double = 0.0
    var stringResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButtion.isSelected = false
        tenPctButtion.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast()) // 뒤에 퍼센트 기호 떼기
//        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)! // 형 변환
        tip = Double(buttonTitleMinusPercentSign)! / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
//        splitNumberLabel.text = String(format: "%.0f", sender.value) 윗 줄이랑 똑같은 기능함
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        totalBill = Double(billTextField.text ?? "0.0")!
        let result = totalBill * (1 + tip) / Double(numberOfPeople)
        stringResult = String(format: "%.2f", result)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.billTotal = stringResult
            destinationVC.person = numberOfPeople
            destinationVC.tipNum = Int(tip * 100)
        }
    }
    
}

