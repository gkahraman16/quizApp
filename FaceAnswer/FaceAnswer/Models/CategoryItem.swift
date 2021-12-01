//
//  CategoryItem.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 30.08.2021.
//

import Foundation
import UIKit

class CategoryItem {
    var name: String?
    var color: UIColor?
    var code: Int?
    
    init(name: String, code: Int){
        self.name = name
        self.color = UIColor(named: name)
        self.code = code
    }
}

