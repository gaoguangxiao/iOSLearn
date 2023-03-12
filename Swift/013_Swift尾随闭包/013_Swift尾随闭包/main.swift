//
//  main.swift
//  013_Swift尾随闭包
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

//函数最后一个参数；
//func play1(param1:String,param2:(String) -> Void) {
//    param2(param1)
//}

//play1(param1: "A", param2: {
//    print("输出" + $0)
//})
//
//play1(param1: "B") { s in
//    print("输出" + s)
//}
//
//play1(param1: "C") { print("输出" + $0)
//}

//func play2(param:(String) -> String)  {
//    var value = param("Swift")
//    print("输出" + value)
//}
//
//play2(param: {(s:String) -> String in
//    return "A" + s
//})
//
//play2 { s in
//    return "B" + s
//}
//
//play2 { return $0 + "C" }

func play3(param:()->Void)  {
    print("play3")
}

play3 {
    
}
