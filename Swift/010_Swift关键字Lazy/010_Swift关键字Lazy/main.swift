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


var test = Test()

//只有使用的时候才初始化
print(test.data)


