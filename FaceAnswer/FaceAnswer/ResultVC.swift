//
//  ResultVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 3.09.2021.
//

import UIKit

class ResultVC: UIViewController {

    var gameScore: Int = 0
    
    @IBOutlet var scoreLabel: UILabel!{
        didSet{
            scoreLabel.text = String(gameScore)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
