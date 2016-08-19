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
        let v = UIView(frame:CGRect(x: 60,y: 100,width: 200,height: 100))
        v.backgroundColor = UIColor.blue()
        return v
    }()
    
    var v2:UIView = {
        let v = UIView(frame:CGRect(x: 60,y: 250,width: 200,height: 100))
        v.backgroundColor = UIColor.yellow()
        return v
    }()
    
    var v3:UIView = {
        let v = UIView(frame:CGRect(x: 60,y: 10,width: 50,height: 50))
        v.backgroundColor = UIColor.orange()
        return v
    }()
    
    var v4:UIView = {
        let v = UIView(frame:CGRect(x: 270,y: 100,width: 10,height: 200))
        v.backgroundColor = UIColor.orange()
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
    
    func panPressAction(_ sender:UIPanGestureRecognizer) {
        if newView == nil {
            return
        }
        switch sender.state {
        case .began, .cancelled, .failed:
            print("")
        case .changed:
            let point = sender.location(in: self)
            if lastPoint1 == nil {
                lastPoint1 = point
            }
            let deltaX = point.x - lastPoint1!.x
            if point.x > 300 || point.x < 270 {
                sender.isEnabled = false
            }
            
            print(point.x)
            
            v4.frame = CGRect(origin: CGPoint(x: v4.frame.origin.x + deltaX, y: v4.frame.origin.y),size: v4.frame.size)
            newView!.frame = CGRect(origin: CGPoint(x: newView!.frame.origin.x, y: newView!.frame.origin.y),size: CGSize(width: newView!.frame.size.width + deltaX, height: newView!.frame.size.height))
            lastPoint = point
            
        case .ended:
            lastPoint1 = nil
            sender.isEnabled = true
        default:
            break
        }
    }
    
    func longPressAction(_ ges:UILongPressGestureRecognizer) {
        switch ges.state {
        case .began:
            tempMove = v3.snapshotView(afterScreenUpdates: false)
            tempMove?.frame = v3.frame
            tempMove?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            v2.addSubview(tempMove!)
        case .changed:
            let point = ges.location(in: self)
            if lastPoint == nil {
                lastPoint = point
            }
            let deltaX = point.x - lastPoint!.x
            let deltaY = point.y - lastPoint!.y
            
            tempMove?.frame = CGRect(origin: CGPoint(x: tempMove!.frame.origin.x + deltaX, y: tempMove!.frame.origin.y + deltaY),size: v3.frame.size)
            lastPoint = point
            
        case .ended:
            tempMove?.transform = CGAffineTransform(scaleX: 1, y: 1)
            buildNewView()
        case .cancelled, .failed:
            print("")
        default:
            break
        }
    }
    
    func buildOldView() {
        let v:UIView = UIView(frame:v3.frame)
        v.backgroundColor = v3.backgroundColor
        v2.addSubview(v);
        v2.sendSubview(toBack: v)
    }
    
    func buildNewView() {
        let rect = v1.convert(tempMove!.frame, from: v2)
        let v:UIView = UIView(frame:rect)
        v.backgroundColor = v3.backgroundColor
        newView = v
        v1.addSubview(v);
        tempMove?.alpha = 0
        tempMove?.removeFromSuperview()
        lastPoint = nil
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("begin123123131312")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ended")
    }
}
