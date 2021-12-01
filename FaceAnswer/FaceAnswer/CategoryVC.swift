//
//  CategoryVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 27.08.2021.
//

import Foundation
import UIKit


class CategoryVC: UIViewController {
    var userName: String = ""
    var categories: [CategoryItem]?
    var categoryDict: [String:Int]?
    @IBOutlet var welcomeMessageLabel:UILabel!{
        didSet{
            welcomeMessageLabel.text = "Hi \(userName), which category would you like to compete in?"
        }
    }
    @IBOutlet var categoryCV: UICollectionView!{
            didSet {
                categoryCV
                    .register(UINib(nibName: String(describing: CategoryCell.self), bundle: nil),
                              forCellWithReuseIdentifier: "CategoryCell")
                categoryCV.allowsMultipleSelection = false
                categoryCV.allowsSelection = true
                
            }
    }
    
    @IBOutlet var startButton: UIButton!{
        didSet {
            startButton.isEnabled = false
            startButton.backgroundColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let generalKnowledge = CategoryItem(name: "General Knowledge", code: 9)
        let history = CategoryItem(name: "History", code: 23)
        let sports = CategoryItem(name: "Sports", code: 21)
        let movies = CategoryItem(name: "Movies", code: 11)
        let books = CategoryItem(name: "Books", code: 10)
        let scienceAndNature = CategoryItem(name: "Science & Nature", code: 17)
        let music = CategoryItem(name: "Music", code: 12)
        let geography = CategoryItem(name: "Geography", code: 22)
        categories = [generalKnowledge, sports, movies, books, scienceAndNature, music, history, geography]
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startGame(){
        performSegue(withIdentifier: "start", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start"{
            guard let selectedIndex = categoryCV.indexPathsForSelectedItems?[0][1] else { return }
            let selectedCategory = categories?[selectedIndex]
            let destinationVC = segue.destination as? QuizVC
            destinationVC?.selectedCategoryCode = selectedCategory?.code
            destinationVC?.userName = userName
        }
    }
    
}

extension CategoryVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            let category = categories?[indexPath.row]
            cell.configure(data: category)
            return cell
        }
            
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = categoryCV.cellForItem(at: indexPath) as? CategoryCell else {
            return
        }
            cell.applySelection()
        startButton.isEnabled = true
        startButton.backgroundColor = .systemYellow
      //  print(categoryCV.indexPathsForSelectedItems?[0])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = categoryCV.cellForItem(at: indexPath) as? CategoryCell else {
            return
        }
            cell.applyDeselection()
    }
}

extension CategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.categoryCV.frame.width / 2 - 8
        let height: CGFloat = 50.0
        return CGSize(width: width, height: height)
    }
}


