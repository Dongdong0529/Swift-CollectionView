//
//  Animation.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/14.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var hideImage:(()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let detailView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let initialFram = presenting ? originFrame : detailView!.frame
        let finalFrame = presenting ? detailView!.frame : originFrame
        
        let xScaleFactor = presenting ? initialFram.width / finalFrame.width : finalFrame.width / initialFram.w
        let yScaleFactor = presenting ? initialFram.height / finalFrame.height : finalFrame.height / initialFram.height
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            detailView?.transform = scaleTransform
            detailView?.center = CGPoint(x: CGRectGetMidX(initialFram), y: CGRectGetMidY(initialFram))
            detailView?.clipsToBounds = true
        }
        
        containerView!.addSubview(toView!)
        containerView?.bringSubviewToFront(detailView!)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .AllowAnimatedContent, animations: { 
            detailView?.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
            detailView?.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }) { (_) in
                if !self.presenting {
                    self.hideImage?()
                }
                transitionContext.completeTransition(true)
        }
    }
}
