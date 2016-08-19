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
    
    func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let toView = transitionContext.view(forKey: UITransitionContextToViewKey)
        let detailView = presenting ? toView : transitionContext.view(forKey: UITransitionContextFromViewKey)!
        let initialFram = presenting ? originFrame : detailView!.frame
        let finalFrame = presenting ? detailView!.frame : originFrame
        
        let xScaleFactor = presenting ? initialFram.width / finalFrame.width : finalFrame.width / initialFram.width
        let yScaleFactor = presenting ? initialFram.height / finalFrame.height : finalFrame.height / initialFram.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            detailView?.transform = scaleTransform
            detailView?.center = CGPoint(x: initialFram.midX, y: initialFram.midY)
            detailView?.clipsToBounds = true
        }
        
        containerView.addSubview(toView!)
        containerView.bringSubview(toFront: detailView!)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: { 
            detailView?.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            detailView?.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }) { (_) in
                if !self.presenting {
                    self.hideImage?()
                }
                transitionContext.completeTransition(true)
        }
    }
}
