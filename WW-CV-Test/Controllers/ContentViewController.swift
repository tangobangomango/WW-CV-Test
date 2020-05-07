//
//  ContentViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/29/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

private let responseSegueIdentifier = "ShowResponse"

class ContentViewController: UIViewController {
    
    var content: TriviaModel?
    var playerNames: [String?] = []

    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = content?.cardContent.uppercased()
        questionLabel.font = UIFont(name: "OPTIKorinna-Agency", size: 50)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == responseSegueIdentifier {
            let destinationVC = segue.destination as? ResponseViewController
            destinationVC?.content = content
            destinationVC?.playerNames = playerNames
        }
    }
    



}


