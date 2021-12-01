//
//  QuizVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 30.08.2021.
//

import Foundation
import UIKit
import CoreData

class QuizVC: FaceDetectionVC {
    
    var timer: Timer?
    var gameScore: Int = 0
    var userName: String = ""
    
    var selectedCategoryCode: Int? = 9
    var questions: [Question] = []
    var index: Int = 0
    
    var isAnswering: Bool {
        return self.horizontalView.count > 0 && self.horizontalView.selectedView == nil
    }
    
    @IBOutlet var horizontalView: HorizontalQuizView!{
        didSet {
            horizontalView.isHidden = true
        }
    }
    
    @IBOutlet var loadingContainerView: UIStackView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var nextButton: UIButton!{
        didSet{
            nextButton.isHidden = true
        }
    }
    @IBOutlet var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchQuestions { [weak self] (questions) in
            self?.questions = questions
            DispatchQueue.main.async {
                self?.horizontalView.isHidden = false
                self?.horizontalView.setupQuestion(data: questions[self?.index ?? 0])
                self?.index += 1
                self?.setupTimer()
                self?.loadingView.stopAnimating()
                self?.loadingContainerView.removeFromSuperview()
            }
        }
       
    }
    
    @IBAction func quit(_ sender: Any) {
        timer?.invalidate()
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func refresh(_ sender: UIButton) {
        gameScore += horizontalView.isAnswerCorrect ? 100 : 0
        if index == 10 {
            performSegue(withIdentifier: "result", sender: nil)
            return
        }
        horizontalView.setupQuestion(data: questions[index])
        nextButton.isHidden = true
        index += 1
    }
   
    override func updateView() {
        horizontalView.rollAngle = roll
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result"{
            let destinationVC = segue.destination as? ResultVC
            destinationVC?.gameScore = gameScore
            save(userName: userName, score: gameScore)
            
        }
    }
    
    func setupTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.isAnswering {
                self.horizontalView.updateCountDown()
            }
            self.nextButton.isHidden = self.isAnswering
        }
    }
    
    func save(userName: String, score: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GameLog", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue(userName, forKeyPath: "userName")
        game.setValue(score, forKeyPath: "score")
        
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save!! \(error)")
        }
    }
    
    func fetchQuestions(completionHandler: @escaping ([Question]) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(selectedCategoryCode ?? 9)&type=multiple") else
        { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching questions: \(error)")
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the status code \(String(describing: response))")
                return
            }
            
            if let data = data,
               let questionCollection = try? JSONDecoder().decode(QuestionResponse.self, from: data) {
                completionHandler(questionCollection.results ?? [])
            }
        })
        task.resume()
    }
}
