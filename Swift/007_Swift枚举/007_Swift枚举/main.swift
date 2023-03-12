//
//  main.swift
//  007_Swift枚举
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

//enum TestEnum {
//    case A
//    case B
//    case C
//}

enum TestEnum {
    case A, B, C
    
    func playT(e:TestEnum) {
        print(e)
    }
}

enum TestNum1:Int {
    case spring = 2,summer,autumn,winter
}

enum TestNum2:String {
    case spring = "春天",summer,autumn,winter
}

enum TestNum3:CaseIterable {
    case spring ,summer,autumn,winter
}

func test(e:TestEnum) {
    switch e {
    case .A:
        print("A")
        fallthrough
    case .B:
        print("B")
        
    case .C:
        print("C")
    default: break
        
    }
}
test(e: .A)

//TestEnum.A.playT(e: .B)
//print(TestEnum.B)
//打印实际的数值
//print(TestNum2.spring.rawValue)


for v in TestNum3.allCases {
    print(v)
}

print(TestNum3.allCases.count)
//TestNum3.AllCases
