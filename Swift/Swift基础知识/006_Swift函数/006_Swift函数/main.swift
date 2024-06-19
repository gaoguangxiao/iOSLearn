//
//  main.swift
//  006_Swift函数
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")


//函数简写
var b : () ->Void
var c : () ->Void = {
    print("c")
}
//print(type(of: b))
//c()

var d = {
}
print(type(of: d))
d()

func test2(params:(Int)-> Void)  {
    params(10)
}

//test2(params: {(a:Int) -> Void in
//  print(a)
//})
//
//test2 { a in
//    print(a)
//}

test2 {print($0)}

//
//func play01(_ value:Int) -> Int {
//    return value * value
//}
//
//func play02(value:Int) -> Int {
//    return value + value
//}
//
////匿名函数作为返回值
//func test(param:Bool) -> (Int)-> Int {
//    param ? play01(_:) : play02(value:)
//}
//
//var a:(Int)->Int = test(param: true)
////a(5)
//print(a(10))
////传一个
//print(test(param: true)(9))



////匿名函数作为函数参数
//func test() {
//    print("test")
//}
//
////定义一个函数类型
//var a:() -> Void = test
////a()
//

//
//func test2(para:()->String) {
//   var s = para()
//   print(s)
//}
//
//func sum(para:(_ c:Int,_ d:Int)->Int) -> Int {
//    return para(4,5)
//}

//test1(para: a)
//test2(para: {() -> String in
//    return "张三"
//})

//test2(para: { return "张三" })

//sum(para: {(a:Int,b:Int)-> Int in
//    return a + b
//})
//var s = sum(para: { return $0 + $1 })
//print(s)
//
//var list = [2,5,2,5,7,3,7,23]
//list.sort { return $0 < $1 }
//print(list)


//TOOL
////函数

//func test1(name:String,age:Int) -> String {
//    return "姓名：" + name +  "年龄：" +  "\(age)"
//}




//var b:() -> Void = {() ->Void in
//    print("b")
//}
//b()
//
//var b1:()->Void = { print("c") }
//b1()


//var c:(String,Int) -> String = test1
//print(c("张三",20))

//var c1:(String,Int) -> String = { (name:String,age:Int) -> String in
//    return "姓名：" + name + "年龄：" +  "\(age)"
//}
//print(c1("张三",20))

//var c2:(String,Int) -> String = { (name:String,age:Int) in
//    return "姓名：" + name + "年龄：" +  "\(age)"
//}
//print(c2("张三",20))

//var c3:(String,Int) -> String = { (name,age)  in
//    return "姓名：" + name + "年龄：" +  "\(age)"
//}
//print(c3("张三",20))

//var c4:(String,Int) -> String = {
//    return "姓名：" + $0 + "年龄：" +  "\($1)"
//}
//print(c4("张三",20))

//var d:([Int]) -> String = { (list:[Int]) -> String in
//    var tmp = ""
//    list.forEach { i in
//        tmp += "\(i)"
//    }
//    return tmp
//}
//
//print(d([2,3,4,6,78,9]))


//var a:String = ""
////定义函数 无参数无返回
//var b:()->Void
//var c:(Int,String) -> String
////参数数组 返回元祖
//let d:([Int]) -> (Int,String)


