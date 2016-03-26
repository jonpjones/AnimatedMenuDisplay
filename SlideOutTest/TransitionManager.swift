//
//  TransitionManager.swift
//  SlideOutTest
//
//  Created by Jonathan Jones on 3/24/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import Foundation
import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        toView!.view.frame = CGRectMake(0.3 * container!.frame.width,
            0.15 * container!.frame.height,
            0.8 * container!.frame.width,
            0.8 * container!.frame.height)
        
        toView!.view.layer.cornerRadius = 15.0
        toView!.view.alpha = 0.0
        toView!.view.layoutSubviews()

        container?.addSubview(toView!.view)
        container?.bringSubviewToFront(toView!.view)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            toView?.view.frame = CGRectMake(container!.frame.origin.x,
                container!.frame.origin.y,
                container!.frame.width,
                container!.frame.height)
            toView!.view.alpha = 1.0
            toView!.view.layer.cornerRadius = 0.0
        
            }) { (Bool) -> Void in
                transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

}
