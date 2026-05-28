//
//  R.swift
//  Demo_SwiftHist
//
//  Created by gaoguangxiao on 2022/4/7.
//

import Foundation
import UIKit

@objc 
extension UIResponder {
    
    func dosomething() {
        print("UIResponder-做些事情\(self)")
        self.next?.dosomething()
    }
}

