//
//  ResponseViewController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/30/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit



class ResponseViewController: UIViewController {

    var content: TriviaModel?
    
   
    @IBOutlet weak var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseLabel.text = content?.correctResponseString

 
    }
    
    
    


}
