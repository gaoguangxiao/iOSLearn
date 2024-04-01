//
//  main.swift
//  002_协议
//
//  Created by 高广校 on 2024/3/28.
//

import Foundation
//import UIKit

print("Hello, World!")


/// 协议的属性必须 带set或 get set
protocol propertyProtocol {
    
    var name: String { get }
    
    //1、需要明确规定该属性是可读的 {get} 、 还是可读可写的 {get set} ；
    var sex: Bool { get set }
    
    //2、属性 必须用var修饰
    static var age: Int {set get}
    
    // 可修改 协议中的值
    mutating func updateName(_ newName: String)
    
    init(name: String)
    
}

protocol propertyInitProtocol {
    var name: String { get }
    
    init(name: String)
    
}

class AA: propertyInitProtocol {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

struct BB: propertyInitProtocol {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 协议继承和遵守，类中为了强调父类的特殊性， 应该将继承的父类写在最前面，遵守的协议写在后面
class Animal {
    
}

class Bird: Animal, propertyProtocol {
    
    var name: String = "1"
    
    var sex: Bool
    
    static var age: Int = 0
    
    func updateName(_ newName: String) {
        
    }
    
    required init(name: String) {
        self.name = name
        self.sex = false
    }
}

struct Persion: propertyProtocol {
    
    var sex: Bool
    
    //3、协议中，static修饰的属性必须赋初始值
    static var age: Int = 0
    
    //结构体中 修改属性时，需要在方法增加mutating，表示该属性能被修改，内部会增加onout传递指针
    mutating func updateName(_ newName: String) {
        name = newName
    }
    
    var name: String = "12"
    
//    init(sex: Bool, name: String) {
//        self.sex = sex
//        self.name = name
//    }
   
    init(name: String) {
        self.name = name
        self.sex = true
    }
    
}

var p = Persion(name: "ggx")
//p.updateName("gx")

let p1: propertyProtocol = p

//p.name = "gx"
//p1.name = "gx" 只读属性，仅仅限制协议这种类型的实例
print(p)

/// 协议的可选实现，那么必须类实现该协议
@objc protocol OptionalProtocol {
    func eat()
    // 实现可选
    @objc optional func play()
}


class Children: OptionalProtocol {
    func eat() {
   
    }
}

//struct Youth: OptionalProtocol {
//    
//}

protocol OptionalProtocol1 {
    func eat()
    
    func play()
}

extension OptionalProtocol1 {
    // 实现可选
    func play() {
        print("可选实现")
    }
}

struct Youth: OptionalProtocol1 {
    func eat() {
        print("吃")
    }
    
    func play() {
        print("实现了")
    }
}

let youth = Youth()
youth.eat()
youth.play()

protocol OneProtocol { 
    func one()
}

protocol TwoProtocol {
    func two()
}

protocol ThreeProtocol: OneProtocol, TwoProtocol {
    
}

typealias FourProtocol = OneProtocol & TwoProtocol

struct CC: FourProtocol {
    func one() {
        
    }
    
//    func one() {
//        
//    }
//    
    func two() {
        
    }
}

//协议指定 只能类遵守
//protocol ClassProtocol: AnyObject { }
//
//struct Test: ClassProtocol { } // 报错

// 协议的关联类型
//associatedtype
protocol LengthMeasurable {
    
    // 协议中定义泛型类型，实现协议的地方 具体类型
    associatedtype AreaType
    
    associatedtype LengthType
    
    var length: LengthType { get }
    
    func printMethod()
}

struct Pencil: LengthMeasurable {
    typealias AreaType = String
    
    typealias LengthType = CGFloat
    var length: CGFloat
    func printMethod() {
        print("铅笔的长度为 \(length) 厘米")
    }
}

struct Bridge: LengthMeasurable {
   
    typealias AreaType = Double
    
    typealias LengthType = Int
    
    var length: Int
    func printMethod() {
        print("桥梁的的长度为 \(length) 米")
    }
}
