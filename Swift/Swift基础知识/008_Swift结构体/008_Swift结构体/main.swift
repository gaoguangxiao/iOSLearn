//
//  main.swift
//  008_Swift结构体
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

struct Student {
    
    var name = "unknow"
    var age = 0
    var score = 0
    
    init(name: String = "unknow", age: Int = 0, score: Int = 0) {
        self.name = name
        self.age = age
        self.score = score
    }
    
    func printDes()  {
        print("姓名：" + self.name + "，年龄：\(self.age)")
    }
    
    private var value = ""
    var school: String {
        //        计算属性 set get private
        set(param){
            print("param:\(param)")
            value = param
        }
        get{
            return value
        }
    }
    
}

struct Area {
    //属性观察
    var area = "北京" {
        willSet(a){
            print(a)
        }
        didSet(b){
            print(b)
        }
        //        get {
        //            return value
        //        }
        //        set {
        //            value = newValue
        //        }
    }
}

//
struct GBPerson<T> {
    var name : T
    init(name: T) {
        self.name = name
    }
}

extension GBPerson {
    func pringInfo()  {
        print("姓名是\(name)")
    }
}

var bperson = GBPerson(name: 100)
bperson.pringInfo()
//bperson.name = 10
//print(bperson.name)

//
//var stu = Student()
//stu.school = "科大"
//print(stu.school)

//var a = Area()
//a.area = "河南"
//print(a.area)

var stu = Student()
stu.name = "张三"
stu.age  = 10
stu.printDes()

//Student(name: T##String, age: <#T##Int#>, score: <#T##Int#>)
//print(stu.name)
