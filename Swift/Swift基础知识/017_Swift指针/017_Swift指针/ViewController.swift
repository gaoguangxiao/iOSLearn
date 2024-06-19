//
//  ViewController.swift
//  017_Swift指针
//
//  Created by 高广校 on 2023/12/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Hello, World!")

        //UnsafePointer：限定类型的指针
        //通过UnsafePointer<T>定义一个类型为T的指针，通过pointee成员即可获得T的值。
        //UnsafePointer作为参数只能接受inout的类型，而inout类型必须是可写的
        func call(_ p: UnsafePointer<Int>) {
            print("\(p.pointee)")
        }

        var number = 5

        call(&number)
        
        
        let numberPointer = UnsafePointer<Int>(&number)
        print(numberPointer)

        //Raw：未处理未加工的
        //#UnsafeRawPointer
        //未指定数据类型指针

        //UnsafeMutableRawPointer:指针指向可变未知类型

        //指针的内存管理
        var p = UnsafePointer<NSData>.alloc(1)
        
    }


}

