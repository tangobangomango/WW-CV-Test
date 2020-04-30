//
//  BoardViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/25/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let contentSegueIdentifier = "ShowContent"
private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
private let itemsPerRow: CGFloat = 6
private let itemsPerColumn: CGFloat = 6
private let topOfCategoryRange = 1000


class BoardViewController: UIViewController {
    
    var questionsAndAnswers: [TriviaModel] = []
    var gameType: TriviaModel.gameType = .single
    
    var triviaManager = TriviaManager()
    
    var boardData: [[TriviaModel]] = []

    let blankSingle = ["", "$100", "$200", "$300", "$400", "$500"]
           
    let blankDouble = ["", "$200", "$400", "$600", "$800", "$1000"]
    

    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        boardCollectionView.register(WWCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        triviaManager.delegate = self
        let catIDS = generateRandomCategories(topOfRange: topOfCategoryRange)
        triviaManager.fetch(catIDS, for: gameType)

    }
    
    func generateRandomCategories(topOfRange: Int) -> [Int] {
        var randomCategories: [Int] = []
        for _ in 0...5 {
            randomCategories.append(Int.random(in: 1...topOfRange))
        }
        return randomCategories
    }
    
    // MARK: - Navigation
    
    
    
    @IBAction func unwindToBoardViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
}

// MARK: - UICollectionView data source
extension BoardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         
        return 1
     }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
         return Int(itemsPerColumn * itemsPerRow)
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WWCollectionViewCell

         let columnNumber = indexPath.row / Int(itemsPerColumn)
         let rowNumber = indexPath.row % Int(itemsPerColumn)
        
        if gameType == TriviaModel.gameType.single {
            cell.label.text = blankSingle[rowNumber]
        } else {
            cell.label.text = blankDouble[rowNumber]
        }
        
        if boardData.count == 6 {
            if rowNumber == 0 {
                let cellLabel = "\(boardData[columnNumber][0].categoryName)"
                cell.label.text = cellLabel.capitalized
               cell.isUserInteractionEnabled = false
            }
            
        }
        
         return cell
     }
    
    
    
}



// MARK: - Collection View Flow Layout Delegate
extension BoardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let horizontalPaddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = collectionView.frame.width - horizontalPaddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      let verticalPaddingSpace = sectionInsets.top  * (itemsPerColumn + 1)
      let availableHeight = collectionView.frame.height - verticalPaddingSpace
      let heightPerItem = availableHeight / itemsPerColumn
      
      return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
     
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }


}

extension BoardViewController: TriviaManagerDelegate {
    
    func didUpdateTriviaData(_ triviaManager: TriviaManager, triviaModels: [[TriviaModel]]) {
        DispatchQueue.main.async {
            print("triviaModel returned")
            print(triviaModels.count)
            if triviaModels.count != 6 {
                let newCategories = self.generateRandomCategories(topOfRange: topOfCategoryRange)
                triviaManager.fetch(newCategories, for: self.gameType)
            }
            self.boardData = triviaModels
            for triviaModel in triviaModels {
                print(triviaModel[0].categoryName)
            }
            self.boardCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
}








    // MARK: UICollectionViewDelegate
extension BoardViewController: UICollectionViewDelegate {
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == contentSegueIdentifier {
            let destinationVC = segue.destination as! ContentViewController
            if let indexPaths = boardCollectionView.indexPathsForSelectedItems {
                let columnNumber = indexPaths[0].row / Int(itemsPerColumn)
                let rowNumber = indexPaths[0].row % Int(itemsPerColumn)
                destinationVC.content = boardData[columnNumber][rowNumber - 1]
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WWCollectionViewCell {
            cell.label.text = ""
            cell.imageView.backgroundColor = UIColor.systemBackground
            cell.isUserInteractionEnabled = false
            
            
        }
        performSegue(withIdentifier: contentSegueIdentifier, sender: self)
    }
    
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    
}


