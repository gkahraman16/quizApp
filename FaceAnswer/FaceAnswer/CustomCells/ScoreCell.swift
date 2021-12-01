//
//  ScoreCell.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 3.09.2021.
//
import Foundation
import UIKit
import CoreData

class ScoreCell: UITableViewCell {

    @IBOutlet var containerView: UIView!{
        didSet {
            containerView.layer.cornerRadius = 20
            containerView.layer.borderWidth = 3
            containerView.layer.borderColor = UIColor.systemOrange.cgColor
        }
    }
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var starImage: UIImageView!{
        didSet{
            starImage.isHidden = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: NSManagedObject?){
        userNameLabel.text = data?.value(forKeyPath: "userName") as? String
        scoreLabel.text = String(data?.value(forKeyPath: "score") as? Int ?? 0 )
    }
    
    func setHighlighted() {
        userNameLabel.font =  UIFont.systemFont(ofSize: 17, weight: .heavy)
        scoreLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
    }
    
    func setDefault(){
        userNameLabel.font =  UIFont.systemFont(ofSize: 17, weight: .regular)
        scoreLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
