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

    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = content?.cardContent

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == responseSegueIdentifier {
            let destinationVC = segue.destination as? ResponseViewController
            destinationVC?.content = content
        }
    }
    



}


