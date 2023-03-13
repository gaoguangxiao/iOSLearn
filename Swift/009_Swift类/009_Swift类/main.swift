//
//  main.swift
//  009_Swift类
//
//  Created by gaoguangxiao on 2023/3/12.
//
/***
 
 类的 继承 多态
 
 扩展 协议 泛型
 
 */
import Foundation


protocol protocal1 {
    
    func play()
}

//遵循这些接口
class Data:protocal1 {
    func play() {
        
    }
    
}

var d = Data()
d.play()


class A {

    var name = ""
    
    init(name:String) {
        self.name = name
    }
    
    func printName() {
        print("this is A " + name)
    }
}

extension A {
    
    var hy: String {
        return "hello"
    }
    
    func toString()  {
        print("A extension")
    }
    
}
//继承
class B : A {
    //重写
    override func printName() {
        print("this is B " + name)
    }
    
    func play()  {
        print("this is B play")
    }
}

class C : A {
    
    override func printName() {
        print("this is C " + name)
    }
}

func getObject(param:Bool) -> A {
    return param ? B(name: "B") : C(name: "C")
}



//对象类型判断
var a = getObject(param: false)
//a.printName()
a.toString()
(a as? B)?.printName()
//print(type(of: a))

//var s1:A = A(name: "张三")
//print(s1.name)
//s1.printName()
//
////父类类型引用 指向子类类型对象【多态】
var s2:A = B(name: "李四")
//s2.printName()

//
////(s2 as? B)?.play()
//
//print(s1 !== s2)

//var s3:B = B(name: "李四")
//print(s3.hy)

toString(param: "123")

toString(param: [1221,1212])
