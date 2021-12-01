//
//  CustomView.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 31.08.2021.
//

import Foundation
import UIKit

protocol CustomViewProtocol {
    var nibName: String { get }
    func commonInit(for customViewName: String)
}

extension CustomViewProtocol where Self: UIView {
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    func commonInit(for customViewName: String) {
        let nib =  UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView(frame: .zero)
        
        addSubview(view)
        view.backgroundColor = .clear
        view.frame = bounds
    }
}
