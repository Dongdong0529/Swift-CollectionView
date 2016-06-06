//
//  MyView.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/3.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    var v1:UIView = {
        let v = UIView(frame:CGRectMake(60,100,200,100))
        v.backgroundColor = UIColor.blueColor()
        return v
    }()
    
    var v2:UIView = {
        let v = UIView(frame:CGRectMake(60,250,200,100))
        v.backgroundColor = UIColor.yellowColor()
        return v
    }()
    
    var v3:UIView = {
        let v = UIView(frame:CGRectMake(60,10,50,50))
        v.backgroundColor = UIColor.orangeColor()
        return v
    }()
    
    var v4:UIView = {
        let v = UIView(frame:CGRectMake(270,100,10,200))
        v.backgroundColor = UIColor.orangeColor()
        return v
    }()
    
    var lastPoint:CGPoint?
    var newView:UIView?
    var lastPoint1:CGPoint?
    
    var tempMove:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(v1)
        self.addSubview(v2)
        self.addSubview(v4)
        v2.addSubview(v3)
        
        let longPress:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MyView.longPressAction(_:)))
        longPress.minimumPressDuration = 0.5
        v3.addGestureRecognizer(longPress)
        
        let pan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MyView.panPressAction(_:)))
        v4.addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func panPressAction(sender:UIPanGestureRecognizer) {
        if newView == nil {
            return
        }
        switch sender.state {
        case .Began, .Cancelled, .Failed:
            print("")
        case .Changed:
            let point = sender.locationInView(self)
            if lastPoint1 == nil {
                lastPoint1 = point
            }
            let deltaX = point.x - lastPoint1!.x
            if point.x > 300 || point.x < 270 {
                sender.enabled = false
            }
            
            print(point.x)
            
            v4.frame = CGRect(origin: CGPointMake(v4.frame.origin.x + deltaX, v4.frame.origin.y),size: v4.frame.size)
            newView!.frame = CGRect(origin: CGPointMake(newView!.frame.origin.x, newView!.frame.origin.y),size: CGSizeMake(newView!.frame.size.width + deltaX, newView!.frame.size.height))
            lastPoint = point
            
        case .Ended:
            lastPoint1 = nil
            sender.enabled = true
        default:
            break
        }
    }
    
    func longPressAction(ges:UILongPressGestureRecognizer) {
        switch ges.state {
        case .Began:
            tempMove = v3.snapshotViewAfterScreenUpdates(false)
            tempMove?.frame = v3.frame
            tempMove?.transform = CGAffineTransformMakeScale(1.3, 1.3)
            v2.addSubview(tempMove!)
        case .Changed:
            let point = ges.locationInView(self)
            if lastPoint == nil {
                lastPoint = point
            }
            let deltaX = point.x - lastPoint!.x
            let deltaY = point.y - lastPoint!.y
            
            tempMove?.frame = CGRect(origin: CGPointMake(tempMove!.frame.origin.x + deltaX, tempMove!.frame.origin.y + deltaY),size: v3.frame.size)
            lastPoint = point
            
        case .Ended:
            tempMove?.transform = CGAffineTransformMakeScale(1, 1)
            buildNewView()
        case .Cancelled, .Failed:
            print("")
        default:
            break
        }
    }
    
    func buildOldView() {
        let v:UIView = UIView(frame:v3.frame)
        v.backgroundColor = v3.backgroundColor
        v2.addSubview(v);
        v2.sendSubviewToBack(v)
    }
    
    func buildNewView() {
        let rect = v1.convertRect(tempMove!.frame, fromView: v2)
        let v:UIView = UIView(frame:rect)
        v.backgroundColor = v3.backgroundColor
        newView = v
        v1.addSubview(v);
        tempMove?.alpha = 0
        tempMove?.removeFromSuperview()
        lastPoint = nil
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("begin")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ended")
    }
}
