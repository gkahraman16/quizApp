//
//  CategoryCell.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 30.08.2021.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet var categoryName: UILabel!
    
    func configure(data: CategoryItem?){
        categoryName.text = data?.name
        contentView.backgroundColor = data?.color
        
    }
    
    func applySelection(){
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
    }
    
    func applyDeselection(){
        contentView.layer.borderWidth = 0
    }
}
