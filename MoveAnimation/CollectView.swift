//
//  CollectView.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/6.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class CollectView: UIView {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.yellow()
        return iv
    }()
    
    static let sharedManage: CollectView = {
        let instance = CollectView()
        return instance
    }()
    
    var action:(() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: ScreenWidth - 100, y: ScreenHeight - 100, width: 60, height: 60))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.addSubview(imageView)
        imageView.frame = self.bounds
    }
    
    func show(inView view:UIView,action:(() -> ())?) {
        self.action = action
        view.addSubview(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if action != nil {
            action!()
        }
    }
}
