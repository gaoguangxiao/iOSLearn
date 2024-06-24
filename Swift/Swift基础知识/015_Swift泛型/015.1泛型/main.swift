//
//  main.swift
//  015.1泛型
//
//  Created by 高广校 on 2024/6/21.
//

import Foundation

var greeting = "Hello, playground"

//FeedMaterial 用 Crop替代
//protocol FeedMaterial {
//    
//}

protocol Crop {
  associatedtype Feed: AnimalFeed where Feed.CropType == Self
  func harvest() -> Feed
}

/// AnimalFeed1用AnimalFeed代替
protocol AnimalFeed1 {
    /// 原料
//    associatedtype Material: FeedMaterial
    /// 食物成长
    static func grow() -> Hay
}

//Self 不仅该类型本身，也包括这个类型的子类
// 官网
protocol AnimalFeed {
  associatedtype CropType: Crop where CropType.Feed == Self
  static func grow() -> CropType
}


protocol Animal {
    associatedtype Feed: AnimalFeed
    func eat(_ food: Feed)
}

//种植苜蓿 -> 干草
///干草
//struct Hay{
//    func harverst() -> Hay {
//        return Hay()
//    }
//}

struct Hay: AnimalFeed {
    static func grow() -> Alfalfa {
        Alfalfa()
    }
}
//苜蓿
//struct Alfalfa: AnimalFeed {
//    static func grow() -> Hay {
//        return Hay()
//    }
//    
//}

struct Alfalfa: Crop {
    func harvest() -> Hay {
        Hay()
    }
}

struct Cow: Animal {
//    typealias Feed = Alfalfa
    
    func eat(_ food: Hay) {
        print("喂养 3: \(food)")
    }
}
//
//struct Hourse: Animal {
//    
//    typealias Feed = Hay
//    
//    func eat(_ food: Hay) {
//        
//    }
//}

// 农场
struct Farm {
    //T需要符合Animal协议
    func feed<T: Animal>(_ animal: T) {
        
    }
    
    func feed1<A>(_ animal: A) where A: Animal {
        print("喂养 1: \(animal)")
    }
    
    func feed2(_ animal: some Animal)  {
        // type(of: ) 动态类型
        // 该动物的食物成长
        let crop = type(of: animal).Feed.grow()
        let produce = crop.harvest()
        animal.eat(produce)
        print("喂养 2: \(animal)")
    }
}

let f = Farm()
f.feed2(Cow())

let fa = Farm.Type
print(fa)
//let c = Cow()
//f.feed1(c)
//f.feed2(c)
//
//let h = Hourse()
//f.feed1(h)
//f.feed2(h)


