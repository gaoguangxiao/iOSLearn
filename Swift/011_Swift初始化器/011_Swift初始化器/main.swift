//
//  main.swift
//  011_Swift初始化器
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

class Test {
    var name = ""
    
//    1、普通初始化器
//    init(name: String = "") {
//        self.name = name
//    }
    
    //2、可失败初始化器
//    init?(name:String) {
//        if name == "unknow" {
//            return nil
//        }
//        self.name = name
//    }
    
//    3、必要初始化器
    required init(name: String = "") {
        self.name = name
    }
}

class A : Test {
    
}

var bl:Int = {
    return 10
}()

//print(bl)


//4、结构体初始化器
struct Person {
    var name : String
    var age = 0
}

var p = Person(name: "张三", age: 12)
print(p.name)


var a = A(name: "张三")
print(a.name)

//var t:Test? = Test(name: "unknow")
//var t = Test(name: "unknow")
//if t == nil {
//    print("初始化失败")
//} else {
//    print(t!.name)
//}

