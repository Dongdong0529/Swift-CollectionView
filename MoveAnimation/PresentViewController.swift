//
//  PresentViewController.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/14.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PresentViewController.dismiss(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    func dismiss(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
