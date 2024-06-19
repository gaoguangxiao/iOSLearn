//
//  main.swift
//  015_Swift泛型
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

print("Hello, World!")

class Data {
    
    var name = ""
    
    init(name: String = "") {
        self.name = name
    }
}

protocol Test {
    associatedtype D:Data
    
    func play(param:D)
}

class Student:Test {
//    func play(param: String) {
//        print(param)
//    }
    func play(param: Data) {
        print(param.name)
    }
}

var s = Student()
//s.play(param: "AA")

s.play(param: Data(name: "BB"))

//泛型
func toString<T>(param:T) {
    print(param)
//    return param
}
