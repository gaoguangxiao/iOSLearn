//
//  AnyHashableBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

struct Person: CustomStringConvertible, CustomDebugStringConvertible{
    var age: Int
    
    var name: String
    
    var job: String
    
    var description: String {
        return "description \(name) age is \(age)"
    }
    
    var debugDescription: String {
        return "debugDescription \(name) age is \(age)"
    }
}

struct AnyHashableBootCamp: View {
    var body: some View {
        
        Button(action: {
            debugPrintInfo()
        }, label: {
            Text("点击")
        })
    
    }
    
    func debugPrintInfo() {
        let meetings = Person(age: 24, name: "herschel", job: "iOS")
//        print(meetings.debugDescription)
        
        // Release 模式打印 "description herschel age is 24"
//        print("print is \(meetings)")
        // debug :debugDescription herschel age is 24
        let s1 = String(describing: meetings)
        print("describing: \(s1)")
        
        let s = String(reflecting: meetings)
        print("reflecting: \(s)")
        
        // 针对，结构体或者类 遵循`CustomDebugStringConvertible`协议，实现了`debugDescription`方法，可通过此打印
//        debugPrint("debugPrint is \(meetings)")
        
//        debug
//        print is description herschel age is 24
//        "debugPrint is description herschel age is 24"

    }
    
}

#Preview {
    AnyHashableBootCamp()
}
