//
//  main.swift
//  014_Swift错误捕获
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

enum TestError:String,Error {
    case error1 = "错误1",error2 = "错误2"
}

func play(param:Int) throws -> String{
    if param < 0 {
        throw TestError.error1
        
    } else if param < 10 {
        throw TestError.error2
    }
    
    return "hello"
}

//var value = try play(param: 0)


do{
    try play(param:9)
}
catch TestError.error1 {
    print(TestError.error1.rawValue)
}
catch TestError.error2 {
    print(TestError.error2.rawValue)
}
defer {
    print("defer")
}
