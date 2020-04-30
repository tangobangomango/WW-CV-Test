//
//  ShowContentAnimator.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/30/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class ShowContentAnimator: NSObject {

}

extension ShowContentAnimator: UIViewControllerAnimatedTransitioning {
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
          if let toVC = transitionContext.viewController(forKey: .to) as? ContentViewController,
            let fromVC = transitionContext.viewController(forKey: .from) as? BoardViewController {
            
            let toView = transitionContext.view(forKey: .to)
            
            if let view = toView {
                transitionContext.containerView.addSubview(view)
            }
            
            let duration = transitionDuration(using: transitionContext)
            let frame = transitionContext.finalFrame(for: toVC)
            
            UIView.animate(withDuration: duration) {
                toView?.frame = frame
                toView?.layoutIfNeeded()
                transitionContext.completeTransition(true)
                }
            
        }
        
    }
    
    
}
