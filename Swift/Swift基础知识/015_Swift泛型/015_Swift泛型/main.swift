//
//  main.swift
//  015_Swift泛型
//
//  Created by gaoguangxiao on 2023/3/12.
//

import Foundation

print("Hello, World!")

class Person {
    var name = ""
    init(name: String = "") {
        self.name = name
    }
}

protocol Animal {
    associatedtype P:Person
    func play(param:P)
}

class Student:Test {
//    func play(param: String) {
//        print(param)
//    }
    func play(param: Person) {
        print(param.name)
    }
}

var s = Student()
//s.play(param: Person(name: "BB"))

//泛型
func toString<T>(param:T) {
    print(param)
//    return param
}
