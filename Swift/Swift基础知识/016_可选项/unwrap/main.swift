//
//  main.swift
//  unwrap
//
//  Created by 高广校 on 2024/6/24.
//

import Foundation

//@Optional

let name: String? = "Antoine van der Lee"

func testUnwrapped() {
    //
    //    guard let unwrappedName = name else {
    //        return
    //    }
    
    //    guard let name else { return }
    
    //    if let unwrappedName = name {
    //        print(unwrappedName.count)
    //    }
    
    //    if let name {
    //        print(name.count)
    //    }
    
    //    print(name?.count ?? 0)
    
//    let validName = name.flatMap { n -> String? in
//        print("n is: \(n)")
//        guard n.count > 500 else { return nil }
//        return n
//    }
//    print(validName ?? "name count empty")
//    
    let c = name?.compactMap({ char in
        print(char)
        return char
    })
    print(c ?? "name count empty1")
}

//flap：
//let possibleNumber: Int? = Int("42")
//let nonOverflowingSquare = possibleNumber.flatMap { x in
//    let (result, overflowed) = x.multipliedReportingOverflow(by: x)
//    return overflowed ? nil : result
//}
//print("nonOverflowingSquare: \(nonOverflowingSquare)")


//testUnwrapped()


/// 为可选枚举 扩展 字符串打印，将字符串自动解包，无值返回nil

let emptyName: String? = nil

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension String? {
    var orEmpty1: String {
        return self ?? ""
    }
}
print("emptyName is: \(emptyName.orEmpty1)")
