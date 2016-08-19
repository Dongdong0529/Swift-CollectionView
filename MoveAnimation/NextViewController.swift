
//
//  NextViewController.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/12.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    var aView: UIView?
    let transition = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white()
        aView = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        aView?.backgroundColor = UIColor.blue()
        self.view.addSubview(aView!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        aView?.shakeViewForTimes(3)
        let present = PresentViewController()
        present.transitioningDelegate = self
        self.present(present, animated: true, completion: nil)
    }
}

extension NextViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissedController dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
