//
//  HorizontalQuizView.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 31.08.2021.
//

import Foundation
import UIKit
import AVFoundation

class HorizontalQuizView: UIView, CustomViewProtocol {
    private var player: AVAudioPlayer?
    
    let leftAngle: Double = 2
    let rightAngle: Double = 1.5
    
    var selectedAnswer: String = ""
    var isAnswerCorrect: Bool {
        return selectedAnswer == question?.correctAnswer
    }
    var count: Int = 10 {
        didSet{
            countdownLabel.text = String(count)
        }
    }
    
    var notAnswered = true
    
    var selectedView: UIView?
    var rollAngle: Double? {
        didSet{
            if notAnswered {
             if rollAngle ?? 0 < rightAngle {
                selectAnswer(answerView: rightView, answer: rightAnswer)
            }else if rollAngle ?? 0 > leftAngle {
                selectAnswer(answerView: leftView, answer: leftAnswer)
            }
            }
        }
    }
    var question: Question?
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var countdownView: UIView!{
        didSet{
            countdownView.layer.cornerRadius = countdownView.frame.size.width/2
        }
    }
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var leftAnswer: UILabel!
    @IBOutlet var rightAnswer: UILabel!
    @IBOutlet var viewsStackView: UIStackView!{
        didSet{
            viewsStackView.isUserInteractionEnabled = false
        }
    }
    @IBOutlet var questionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(for: "HorizontalQuizView")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(for: "HorizontalQuizView")
    }
    
    func setupQuestion(data: Question?){
        resetView()
        self.question = data
        questionLabel.text = data?.question
        let answers = [data?.correctAnswer,data?.incorrectAnswers?[Int.random(in: 0...2)]].shuffled()
        leftAnswer.text = answers[0]
        rightAnswer.text = answers[1]
    }
    
    func resetView(){
        resetAnswers()
        countdownView.isHidden = false
        self.count = 10
    }
    
    func selectAnswer(answerView: UIView, answer: UILabel){
        DispatchQueue.main.async {
            self.notAnswered = false
            self.countdownView.isHidden = true
            self.selectedAnswer = answer.text ?? ""
            self.selectedView = answerView
            self.selectedView?.layer.borderWidth = 3
            self.selectedView?.layer.borderColor = UIColor.white.cgColor
            self.selectedView?.backgroundColor = self.isAnswerCorrect ? AppColor.correct : AppColor.incorrect
            let soundFileName = self.isAnswerCorrect ? "Correct_answer" : "Fail_sound"
            self.playSound(name: soundFileName, withExtension: "mp3")
        }
    }
    
    func deselectLeftAnswer(){
        leftView.layer.borderWidth = 0
        leftView.layer.backgroundColor =  AppColor.left
    }
    
    func deselectRightAnswer(){
        rightView.layer.borderWidth = 0
        rightView.layer.backgroundColor =  AppColor.right
    }
    
    func resetAnswers(){
        deselectLeftAnswer()
        deselectRightAnswer()
        notAnswered = true
        selectedAnswer = ""
        selectedView = nil
    }
 
    @objc func updateCountDown(){
        if count <= 1 {
           setTimeOut()
        }
        count -= 1
    }
    
    func setTimeOut(){
        notAnswered = false
        countdownView.isHidden = true
        if question?.correctAnswer == leftAnswer.text {
            leftView.backgroundColor = AppColor.timeout
            leftView.layer.borderWidth = 3
            leftView.layer.borderColor = UIColor.white.cgColor
        }else{
            rightView.backgroundColor = AppColor.timeout
            rightView.layer.borderWidth = 3
            rightView.layer.borderColor = UIColor.white.cgColor
        }
        playSound(name: "timeout", withExtension: "wav")
    }
    
    func playSound(name: String, withExtension: String){
        guard let soundFileURL = Bundle.main.url(
            forResource: name,
            withExtension: withExtension
            ) else {
                print("sound file not found")
                return
            }
            
            do {
                // Configure and activate the AVAudioSession // Configure and activate the AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: AVAudioSession.Mode.default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVAudioPlayer(contentsOf: soundFileURL)
                guard let player = player else { return }
                player.play()
            }
            catch {
                // Handle error
                print("sound file found not played")
            }
    }
}
