//
//  SwiftWeakProxy.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2023/12/21.
//

import UIKit

/// 处理timer强引用类
class SwiftWeakProxy: NSObject {
    weak var target:NSObjectProtocol?
    public init(_ target:NSObjectProtocol?) {
        super.init()
        self.target = target
    }
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if self.target?.responds(to: aSelector) == true {
            return self.target
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }
    
    deinit {
        print("\(self)-deinit")
    }
}
