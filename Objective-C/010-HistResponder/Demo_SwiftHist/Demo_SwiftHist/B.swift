//
//  B.swift
//  Demo_SwiftHist
//
//  Created by gaoguangxiao on 2022/4/7.
//

import Foundation
import UIKit

class B: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let btn = UIButton(type: .custom)
        
        btn.frame = bounds
        btn.setTitle("点击", for: .normal)
        btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func tapT()  {
//        print("tapT")
//    }
    
    //按钮点击事件加入
    @objc
    func tap() {
        print("B执行了");
       
//        1、查找上一层响应者，寻找能响应的类。具体的类需要实现@objc方法
//        2、加入private属性，外界也能访问
        
//        let c = self.next?.next?.next as? UIViewController
//        let sel = NSSelectorFromString("dosomething")
//        c?.perform(sel)
        
//        2、
        self.dosomething()
//        tapT()
        
//        testPrivateAccess()
        
//        DispatchQueue.global().async {
            
            self.perform(#selector(self.testFileprivateAccess), with: nil, afterDelay: 3.0)

//        }
        
//        let age = 10
//        let name = "ggx"
//        let sel = NSSelectorFromString("setAgeWithAge:name:")
//        ((void(*)(id,SEL,NSNumber*,NSString*,NSString*,NSArray*)) objc_msgSend)(self,selector,age,name,gender,friends);
    }
    
    
    //使用perform进行多值传递
    @objc func setAge(age:Int,name:String) {
        print(age,name)
    }
    
    //用private修饰的函数 或者属性，只能本类访问
    private func testPrivateAccess() {
        print("private修饰的函数");
    }
    
    @objc fileprivate func testFileprivateAccess() {
        print("fileprivate修饰的函数")
    }
    
    func testInternalAccess() {
        print("private访问控制关键字控制");
    }
}

class B1: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let b = B()
//        b.testFileprivateAccess()
        
//        b.perform, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
