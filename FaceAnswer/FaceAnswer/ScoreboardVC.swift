//
//  ScoreboardVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 3.09.2021.
//

import UIKit
import CoreData

class ScoreboardVC: UIViewController {

    var gameLogs: [NSManagedObject]? {
        didSet{
            scoreTable.reloadData()
        }
    }
    
    var maxScore: Int?
    
    @IBOutlet var scoreTable: UITableView!{
        didSet{
            scoreTable.register(UINib(nibName: "ScoreCell", bundle: nil), forCellReuseIdentifier: "ScoreCell")
            scoreTable.allowsSelection = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameLog")
            
            do{
                gameLogs = try managedContext.fetch(fetchRequest)
                maxScore = gameLogs?.sorted(by: {$0.value(forKeyPath: "score") as! Int > $1.value(forKeyPath: "score") as! Int}).first?.value(forKeyPath: "score") as? Int
                print(maxScore ?? "")
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

  
}

extension ScoreboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameLogs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellView = tableView.dequeueReusableCell(withIdentifier: "ScoreCell",
                                 for: indexPath) as? ScoreCell {
            let game = gameLogs?[indexPath.row]
            cellView.configure(data: game)
            if indexPath.row == (gameLogs?.count ?? 0) - 1 {
                cellView.setHighlighted()
            }else{
                cellView.setDefault()
            }
            cellView.starImage.isHidden = game?.value(forKeyPath: "score") as? Int != maxScore
            return cellView
        }
        return UITableViewCell()
    }
    
    
}
