//
//  main.swift
//  UnknownDefault
//
//  Created by 高广校 on 2024/7/9.
//

import Foundation

print("Hello, World!")

//默认枚举需要增加`@unknown default`匹配位置情况，
enum Season : Int{
    case spring = 1,summer,autumn,winter
}


func frozenTest()  {
    
    let season : Season = .winter

    switch season {
    case .spring:
        print("春天")
    case .summer:
        print("夏天")
    case .autumn:
        print("秋天")
//    case .winter:
//        print("冬天")
    @unknown default:
        print("\(season.rawValue)")
        
    }
//    default:
//        print("默认")
//    }
}

frozenTest()
