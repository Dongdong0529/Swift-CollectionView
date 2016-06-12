//
//  PopupAnimationView.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/12.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class PopupAnimationView: UIView {
    
    private lazy var contentLabel:UILabel = {
        let l = UILabel()
        l.textColor = UIColor.whiteColor()
        l.font = UIFont.systemFontOfSize(14)
        l.textAlignment = .Center
        return l
    }()
    
    var completion:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueColor()
        self.addSubview(contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(message: String, inView:UIView, yOffset:CGFloat, delay:NSTimeInterval) {
        show(message, inView: inView, yOffset: yOffset, delay: delay, handler: nil)
    }
    
    class func show(message: String, inView:UIView, yOffset:CGFloat, delay:NSTimeInterval, handler:(()->())?) {
        let v = PopupAnimationView()
        v.show(message, inView: inView, yOffset: yOffset, delay: delay, handler: handler)
    }
    
    func show(message: String, inView:UIView, yOffset:CGFloat, delay:NSTimeInterval, handler:(()->())?) {
        inView.addSubview(self)
        self.frame = CGRectMake(0, yOffset, UIScreen.mainScreen().bounds.size.width, 30)
        completion = handler
        contentLabel.text = message
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .LayoutSubviews, animations: {
            self.contentLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (finished) in
                UIView.animateWithDuration(0.2, delay: 0, options: .LayoutSubviews, animations: { 
                    self.contentLabel.transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        
                })
        }
        self.performSelector(#selector(PopupAnimationView.dismiss), withObject: nil, afterDelay: delay)
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.5, animations: { 
            self.alpha = 0
            }) { (finished) in
            self.removeFromSuperview()
        }
        completion?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.frame = bounds
    }
}
