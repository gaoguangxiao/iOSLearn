//
//  ViewController.swift
//  SwiftRandom
//
//  Created by 高广校 on 2023/12/14.
//

import UIKit

enum WeekDay: CaseIterable {
    
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
//    static func random()<G: RandomNumberGenerator>(using generator: inout G) -> WeekDay {
//        
//        return Weekday.
//    }
//    
//    static func random() -> WeekDay {
//        var g = SystemRandomNumberGenerator()
//        return WeekDay.random()
//        
//    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        RandomNumberGenerator：一种提供均匀分布的随机数据的类型
        let randomString = randomAlphanumericString(5)
        print(randomString)
        
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        let randomString = (0..<10).map{ _ in
//            String(letters.randomElement()!)
//        }.reduce("", +)
//        randomString = randomString.reduce("", +)
        //reduce是一个非常好用的高阶函数，可以将数组或序列的所有元素合并为单个值【用于序列元素的累加】
//        randomString = randomString.reduce("", { partialResult, str in
//            "+"
//        })
        print(randomString)
    }

    func randomAlphanumericString(_ length: Int) -> String {
       let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
       let len = UInt32(letters.count)
       var random = SystemRandomNumberGenerator()
       var randomString = ""
       for _ in 0..<length {
//          let randomIndex = Int(random.next(upperBound: len))
           let randomIndex = Int.random(in: 0..<Int(len))
          let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
          randomString.append(randomCharacter)
       }
       return randomString
    }
}

