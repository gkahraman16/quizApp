//
//  HowToPlayVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 4.09.2021.
//

import UIKit

class HowToPlayVC: UIViewController {

    @IBOutlet var rulesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesLabel.text = """
            FaceAnswer is a quiz app that users can answer questions by their face movements.\nWe offer you 8 interesting category options to test yourself. Each quiz consists of 10 questions with two choices. You can answer questions by tilting your head to the left or right. Remember you have 10 seconds to solve each question.\n\nGood Luck!
            """
    }

    @IBAction func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
