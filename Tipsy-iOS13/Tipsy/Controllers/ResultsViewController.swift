//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by 김도연 on 12/26/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    var billTotal = ""
    var person: Int = 0
    var tipNum: Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = billTotal
        settingsLabel.text = "Split between \(person) people, with \(tipNum)% tip."

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
