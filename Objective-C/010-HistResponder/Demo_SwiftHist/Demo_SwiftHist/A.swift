//
//  A.swift
//  Demo_SwiftHist
//
//  Created by gaoguangxiao on 2022/4/7.
//

import Foundation
import UIKit

class A: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let b = B(frame: frame)
        b.backgroundColor = .yellow
        addSubview(b)
        
//        let queue = DispatchQueue.global().sync {
//            
//        }
//        
        
        //B文件的方法，
        b.testInternalAccess()
//        let b1 = B1()
        
    }

    func readData()  {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func dosomething() {
//        print("A执行了");
//    }
}
