//
//  frozen.swift
//  007_Swift枚举
//
//  Created by 高广校 on 2023/11/10.
//

import Foundation


//默认枚举需要增加`@unknown default`匹配位置情况，
public enum Season : Int{
    case spring = 1,summer,autumn,winter
}


func frozenTest()  {
    print("1")
    
    let season : Season = .summer

    switch season {
    case .spring:
        print("春天")
    case .summer:
        print("夏天")
    case .autumn:
        print("秋天")
    case .winter:
        print("冬天")
//    @unknown default:
//        fatalError()
    }
//    default:
//        print("默认")
//    }
}
