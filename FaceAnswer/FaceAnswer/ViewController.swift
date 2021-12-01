//
//  ViewController.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 27.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userNameField: CustomTextField!{
        didSet{
            userNameField.setValidationConstraints(minChar: 2, maxChar: 15, isEmojiAccepting: false)
            userNameField.addTarget(self, action: #selector(applyValidationResult(_:)), for: UIControl.Event.editingChanged)
        }
    }
    @IBOutlet var playButton: UIButton!
    @IBOutlet var howToPlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func openCategoryPage(){
        if userNameField.isValid {
            performSegue(withIdentifier: "play", sender: nil)
        }
    }
    
    @IBAction func openFaceDetection(){
        self.navigationController?.pushViewController(HowToPlayVC(), animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play"{
            let destinationVC = segue.destination as? CategoryVC
            destinationVC?.userName = userNameField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        }
    }
    
    @objc func applyValidationResult(_ sender:CustomTextField){
        sender.isValid ? sender.applyNormalView() : sender.applyErrorView()
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
