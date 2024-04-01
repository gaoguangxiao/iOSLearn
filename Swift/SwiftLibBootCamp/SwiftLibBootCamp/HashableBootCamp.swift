//
//  HashableBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

struct HashableStruct: Hashable{
    let name: String
    let age: Int
    
//    Swift4.2弃用
//    var hashValue: Int {
//        return age.hashValue ^ name.hashValue &* 16777619
//    }
//    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
}

struct HashableBootCamp: View {
    var body: some View {
        Button(action: {
            testHashable()
        }, label: {
            Text("点击")
        })
    }
    
    func testHashable()  {
        print("testHashable")
        
        let a = HashableStruct(name: "herschel", age: 10)
        let b = HashableStruct(name: "herschel", age: 11)
        let c = HashableStruct(name: "herschel", age: 10)
//
//        print("1 hashValue is \(1.hashValue)")
        print("a \(a.hashValue)")
        print("b \(b.hashValue)")
        print("c \(c.hashValue)")
        
        print("a is equal b \(a == b)")
        print("a is equal c \(a == c)")
    }
}

#Preview {
    HashableBootCamp()
}
