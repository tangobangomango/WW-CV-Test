//
//  BoardViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/25/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
private let itemsPerRow: CGFloat = 6
private let itemsPerColumn: CGFloat = 6


class BoardViewController: UIViewController {
    
    var questionsAndAnswers: [TriviaModel] = []
    var difficulty: TriviaModel.gameType = .single
    
    var triviaManager = TriviaManager()
    
    var boardData: [[TriviaModel]] = []

    
    
    let data = [
        ["Category 1", "$100", "$200", "$300", "$400", "$500"],
        ["Category 2", "$100", "$200", "$300", "$400", "$500"],
        ["Category 3", "$100", "$200", "$300", "$400", "$500"],
        ["Category 4", "$100", "$200", "$300", "$400", "$500"],
        ["Category 5", "$100", "$200", "$300", "$400", "$500"],
        ["Category 6", "$100", "$200", "$300", "$400", "$500"]
    ]
    

    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        boardCollectionView.register(WWCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        triviaManager.delegate = self
        let catIDS = [57, 1, 5, 7, 11531, 11532]
        triviaManager.fetch(catIDS)

    }
    
    func getTriviaData() {
        var categoryList: [Int] = []
        for i in 0...5 {
           categoryList[i] = Int.random(in: 1...100)
        }
        
//        triviaManager.fetchTrivia(for: categoryList)
    }
}

// MARK: - UICollectionView data source
extension BoardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         // #warning Incomplete implementation, return the number of sections
         return 1
     }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of items
         return Int(itemsPerColumn * itemsPerRow)
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WWCollectionViewCell
//         cell.backgroundColor = UIColor.systemGray
         // Configure the cell
         let columnNumber = indexPath.row / Int(itemsPerColumn)
         let rowNumber = indexPath.row % Int(itemsPerColumn)
         cell.label.text = data[columnNumber][rowNumber]
        
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
//            self.questionsAndAnswers = triviaModel
////            print("triviaModel returned")
//            self.tableView.reloadData()
//            let category = self.questionsAndAnswers[0].categoryName
//            let titleString = category.capitalized
//            self.title = titleString
            print(triviaModels.count)
            self.boardData = triviaModels
            for triviaModel in triviaModels {
                print(triviaModel[0].categoryName)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}








    // MARK: UICollectionViewDelegate
extension BoardViewController: UICollectionViewDelegate {
  
    

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


