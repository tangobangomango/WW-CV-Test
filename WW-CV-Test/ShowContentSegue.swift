//
//  ShowContentSegue.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/30/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class ShowContentSegue: UIStoryboardSegue {
 
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension ShowContentSegue: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ShowContentAnimator()
    }
}
