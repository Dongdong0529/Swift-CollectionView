//
//  Singleton.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/14.
//  Copyright © 2016年 com. All rights reserved.
//

import Foundation
import UIKit

let s = Util()

class Util: NSObject {
    
    //1
    static let instance1 = Util()
    
    //2
    class func instance2() -> Util {
        struct Single {
            static var onceToken: dispatch_once_t = 0
            static var sing: Util?
        }
        dispatch_once(&Single.onceToken) { 
            Single.sing = Util()
        }
        return Single.sing!
    }
    
    //3
    class var instance3: Util {
        return s
    }
    
    //4
    static var instance4: Util {
        struct Static {
            static let ins: Util = Util()
        }
        return Static.ins
    }
}
