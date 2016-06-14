
//
//  NextViewController.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/12.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class NextViewController: UIViewController {
    var aView: UIView?
    let transition = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aView = UIView(frame: CGRectMake(100, 200, 100, 100))
        aView?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(aView!)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        aView?.shakeViewForTimes(3)
        let present = PresentViewController()
        present.transitioningDelegate = self
        self.presentViewController(present, animated: true, completion: nil)
    }
}

extension NextViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}