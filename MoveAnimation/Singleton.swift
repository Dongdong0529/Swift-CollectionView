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
//    private static var __once: () = { 
//            Single.sing = Util()
//        }()
    var name: String?
    //1
    static let instance1 = Util()
    
    //2
//    class func instance2() -> Util {
//        struct Single {
//            static var onceToken: Int = 0
//            static var sing: Util?
//        }
//        _ = Util.__once
//        return Single.sing!
//    }
    
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
    
    func test() {
        let i = doSomething { (subClosure) -> Int in
            return subClosure()
        }
        print("----------\(i)")
    }
    
    
    func doSomething(_ closure:(subClosure:()-> Int)->Int) -> Int {
        let b:()->Int = {()->Int in
            return 10
        }
        return closure(subClosure: b)
    }
}
