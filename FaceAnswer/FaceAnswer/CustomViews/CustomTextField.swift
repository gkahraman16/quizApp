//
//  CustomTextField.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 2.09.2021.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    private var maxCount: Int = 0
    private var minCount: Int = 0
    var isEmojiAccepting: Bool = false
    
    var textPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    var isValid: Bool {
        get {
            var valid = true
            if let text = text?.trimmingCharacters(in: .whitespaces) {
                if maxCount > 0{
                    valid = text.count <= maxCount
                }
                valid = valid && text.count >= minCount && !text.isEmpty && (isEmojiAccepting || !text.containsEmoji)
            }
            return valid
        }
    }
    
    func setValidationConstraints(minChar: Int = 0,
                                  maxChar: Int = 0,
                                  isEmojiAccepting: Bool = false){
        if minChar < 0 {
            minCount = 0
        }else{
            minCount = minChar
        }
        if maxChar < minCount {
            maxCount = minCount
        }else{
            maxCount = maxChar
        }
        self.isEmojiAccepting = isEmojiAccepting
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    func applyErrorView(){
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
    }
    
    func applyNormalView(){
        layer.borderWidth = 0
    }
}



