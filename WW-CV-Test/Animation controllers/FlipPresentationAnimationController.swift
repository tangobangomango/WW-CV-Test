//
//  FlipPresentationAnimationController.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/30/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit

class FlipPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("amimating")
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = originFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1 / 3)
                {
                    fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3)
                {
                    snapshot.layer.transform = AnimationHelper.yRotation(0.0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3)
                {
                    snapshot.frame = finalFrame
                    
                }
                
        }) { (_) in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
    

}
