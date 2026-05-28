//
//  ViewController.swift
//  Demo_SwiftHist
//
//  Created by gaoguangxiao on 2022/4/7.
//

import UIKit

class ViewController: UIViewController {
//    @objc dynamic var age: Int = 0 //@objc修饰属性，告诉编译器需要动态编译的
    @objc dynamic var name : String = "" //dynamic需要程序员手动实现set和get方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let a = A(frame: CGRect(x: 0, y: 10, width: 90, height: 90))
        a.backgroundColor = .red
        view.addSubview(a)
//        self.setValue("ggx", forKey:"name")
//        print(value(forKey: "name"))
    }
    
//    override class var accessInstanceVariablesDirectly:  = <#initializer#>Bool

//    1、类private 增加此属性，外界也能访问
//    @objc private func dosomething() {
//        print("VC-做些事情")
//    }


    override func dosomething() {
        print("VC-做些事情")
    }
}

