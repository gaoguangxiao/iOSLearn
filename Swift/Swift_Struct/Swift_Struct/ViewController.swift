//
//  ViewController.swift
//  Swift_Struct
//
//  Created by gaoguangxiao on 2022/9/13.
//

//1、为结构体属性赋值时，如果属性有默认的值或者空，编译器可以编译通过。
struct Date {
    var year : Int
    var month : Int
    var day : Int?
    var hour : String?
        
    init(year: Int, month: Int, day: Int? = nil, hour: String? = nil) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
    }
    
}


struct Person {
    var weight : Double
    var height : Double
    
    //lazy 惰性变量 是按需初始化的存储属性，只能在struct和class使用
//    lazy var BMIIndex: Double = {
//        print("引用一次")//打印几次
//        return self.weight/pow(self.height, 2)
//    }()
    
    mutating func updateHeight(h:Double) {
        self.height = h
    }
    
    var BMIIndex: Double {
//        print("引用一次") //打印几次
        return self.weight/pow(self.height, 2)
    }
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let date = Date(year: 2022, month: 9, day: 10)
//        let date1 = Date(year: <#T##Int#>, month: <#T##Int#>)
//        print(date)
        
        let p = Person(weight: 90, height: 120)
        print(p.BMIIndex)
//        p.height = 130 //如果；let修饰结构体，里面内存布局是不允许修改的，需要var修饰才可以
        print(p.BMIIndex)
//        Bool
//
//        Int
//
//        Array
//
//        String
//
//        Dictionary
        // Do any additional setup after loading the view.
    }


}

