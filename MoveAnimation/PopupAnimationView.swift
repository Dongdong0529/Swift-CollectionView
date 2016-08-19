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
        l.textColor = UIColor.white()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    var completion:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue()
        self.addSubview(contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    class func show(_ message: String, inView: UIView, yOffset: CGFloat, delay: TimeInterval) {
        show(message, inView: inView, yOffset: yOffset, delay: delay, handler: nil)
    }
    
    class func show(_ message: String, inView: UIView, yOffset: CGFloat, delay: TimeInterval, handler:(()->())?) {
        let v = PopupAnimationView()
        v.show(message, inView: inView, yOffset: yOffset, delay: delay, handler: handler)
    }
    
    func show(_ message: String, inView: UIView, yOffset: CGFloat, delay: TimeInterval, handler:(()->())?) {
        inView.addSubview(self)
        self.frame = CGRect(x: 0, y: yOffset, width: UIScreen.main().bounds.size.width, height: 30)
        completion = handler
        contentLabel.text = message
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .layoutSubviews, animations: {
            self.contentLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (finished) in
                UIView.animate(withDuration: 0.1, delay: 0, options: .layoutSubviews, animations: {
                    self.contentLabel.transform = CGAffineTransform.identity
                    }, completion: { (finished) in
                        
                })
        }
        self.perform(#selector(PopupAnimationView.dismiss), with: nil, afterDelay: delay)
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: { 
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
