//
//  main.swift
//  010_Swift关键字Lazy
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

class Data {
    
    init() {
        print("init data")
    }
}

class Test {
//    var data = Data()
    
    init() {
        print("init Test")
    }
    
//    lazy var data: Data = {
//        let td = Data()
//        return td
//    }()
    
    //懒加载
    lazy var data = Data()
}

//area 面积
//圆 radio

//圆的面积
struct Area {
    
    var radio = 0.0
    
    init(radio: Double = 0.0) {
        self.radio = radio
    }
    
    //只加载一次
   lazy var area: Double = {
        print("计算")
        return self.radio * self.radio * M_PI
    }()
    
}

//var test = Test()
//只有使用的时候才初始化
//print(test.data)

var a = Area(radio: 10)
let a1 = a.area
print(a1)
a.radio = 5
let a2 = a.area
print(a2)
let a3 = a.area
print(a3)





