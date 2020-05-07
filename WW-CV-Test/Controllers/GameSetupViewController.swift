//
//  GameSetupViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 5/4/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var player1NameTextField: UITextField!
    @IBOutlet weak var player2NameTextField: UITextField!
    @IBOutlet weak var player3NameTextField: UITextField!
    @IBOutlet weak var gameTypeChoice: UISegmentedControl!
    
//    var playerNames: [String?] = []
    var gameType: TriviaModel.gameType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1NameTextField.delegate = self
        player2NameTextField.delegate = self
        player3NameTextField.delegate = self
        styleSegmentedControl()
        
    }
    
    func styleSegmentedControl() {
        // https://stackoverflow.com/questions/56436559/how-to-change-the-colors-of-a-segment-in-a-uisegmentedcontrol-in-ios-13
        
        if #available(iOS 13.0, *) {
            gameTypeChoice.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.01568627451, blue: 0.5215686275, alpha: 1)
            gameTypeChoice.layer.borderColor = UIColor.white.cgColor
            gameTypeChoice.selectedSegmentTintColor = UIColor.white
            gameTypeChoice.layer.borderWidth = 1
            
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            gameTypeChoice.setTitleTextAttributes(titleTextAttributes, for: .normal)
            let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.0862745098, green: 0.01568627451, blue: 0.5215686275, alpha: 1)]
            gameTypeChoice.setTitleTextAttributes(titleTextAttributes2, for: .selected)
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        if player1NameTextField.text == "" && player2NameTextField.text == "" && player3NameTextField.text == "" {
            let alert = UIAlertController(title: "Enter a Player", message: "You need to add at least one player", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        } else {
           performSegue(withIdentifier: "ShowBoard", sender: self)
        }
        
        
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
//            print(gameType)
            destinationVC.playerNames = playerNames
            destinationVC.gameType = gameType!
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // https://www.hackingwithswift.com/example-code/uikit/how-to-move-to-the-next-uitextfield-when-the-user-presses-return
        
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
 

}
