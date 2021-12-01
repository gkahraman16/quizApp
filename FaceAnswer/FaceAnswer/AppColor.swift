//
//  AppColors.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 4.09.2021.
//

import Foundation
import UIKit

struct AppColor {
    static let left = UIColor(red: 0.399, green: 0.033, blue: 0.945, alpha: 0.3).cgColor
    static let leftSelected = UIColor(red: 0.399, green: 0.033, blue: 0.945, alpha: 0.7).cgColor
    static let right = UIColor(red: 0.962, green: 1.0, blue: 0.002, alpha: 0.3).cgColor
    static let rightSelected = UIColor(red: 0.962, green: 1.0, blue: 0.002, alpha: 0.7).cgColor
    static let top =  UIColor(red: 0.96, green: 0.72, blue: 0, alpha: 0.3).cgColor
    static let topSelected =  UIColor(red: 0.96, green: 0.72, blue: 0, alpha: 0.7).cgColor
    static let bottom = UIColor(red: 0, green: 0.724, blue: 0.672, alpha: 0.3).cgColor
    static let bottomSelected = UIColor(red: 0, green: 0.724, blue: 0.672, alpha: 0.7).cgColor
    static let correct = UIColor(red: 0, green: 1, blue: 0, alpha: 0.7)
    static let incorrect =  UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
    static let timeout =  UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
}
