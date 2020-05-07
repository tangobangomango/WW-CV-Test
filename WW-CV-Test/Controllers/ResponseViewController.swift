//
//  ResponseViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/30/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

//protocol ResponseDelegate {
//    func didUpdateScore(scoreChange: [Int])
//}



class ResponseViewController: UIViewController {

    var content: TriviaModel?
//    var delegate: ResponseDelegate?
    var newScores = [0, 0, 0]
    var playerNames: [String?] = []
   
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2CorrectButton: GradientButton!
    @IBOutlet weak var player2WrongButton: GradientButton!
    
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player3CorrectButton: GradientButton!
    @IBOutlet weak var player3WrongButton: GradientButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseLabel.text = content?.correctResponseString.uppercased()
        responseLabel.font = UIFont(name: "OPTIKorinna-Agency", size: 50)
        deactivateAndHideButtons()
        
 
    }
    
    func deactivateAndHideButtons() {
        
        if playerNames[1] == "" {
            player2NameLabel.text = ""
            player2CorrectButton.isEnabled = false
            player2CorrectButton.isHidden = true
            player2WrongButton.isEnabled = false
            player2WrongButton.isHidden = true
        }
        
        if playerNames[2] == "" {
            player3NameLabel.text = ""
            player3CorrectButton.isEnabled = false
            player3CorrectButton.isHidden = true
            player3WrongButton.isEnabled = false
            player3WrongButton.isHidden = true
        }
    }
    
    
    @IBAction func correctPlayer1(_ sender: UIButton) {
        newScores[0] = (content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    
    @IBAction func wrongPlayer1(_ sender: UIButton) {
        newScores[0] = -(content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    
    @IBAction func correctPlayer2(_ sender: UIButton) {
        newScores[1] = (content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    @IBAction func wrongPlayer2(_ sender: UIButton) {
        newScores[1] = -(content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    @IBAction func correctPlayer3(_ sender: UIButton) {
        newScores[2] = (content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    @IBAction func wrongPlayer3(_ sender: UIButton) {
        newScores[2] = -(content?.value)!
        performSegue(withIdentifier: "UnwindToBoard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindToBoard" {
            let destinationVC = segue.destination as? BoardViewController
            destinationVC?.newScores = newScores
            
        }
    }
    
    
    


}
