//
//  GameSetupViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 5/4/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController {

    @IBOutlet weak var player1NameTextField: UITextField!
    @IBOutlet weak var player2NameTextField: UITextField!
    @IBOutlet weak var player3NameTextField: UITextField!
    @IBOutlet weak var gameTypeChoice: UISegmentedControl!
    
//    var playerNames: [String?] = []
    var gameType: TriviaModel.gameType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBoard" {
            let destinationVC = segue.destination as! BoardViewController
            let playerNames = [player1NameTextField.text, player2NameTextField.text, player3NameTextField.text]
            if gameTypeChoice.selectedSegmentIndex == 0 {
                gameType = TriviaModel.gameType.single
            } else {
                gameType = TriviaModel.gameType.double
            }
            print(gameType)
            destinationVC.playerNames = playerNames
            destinationVC.gameType = gameType!
            
        }
    }
 

}
