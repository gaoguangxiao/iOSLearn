//
//  ContentView.swift
//  002_标准库协议
//
//  Created by 高广校 on 2024/3/28.
//

import SwiftUI

struct Animal: Hashable {
    
    var name: String
}

// 比较两个人的年龄
struct Person: Comparable, CustomStringConvertible {
    
    var name: String
    
    var age = 0
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age < rhs.age
    }
    
    var description: String {
        return "\(name)的年龄\(age)"
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
        
            Button(action: {
                TComparable()
            }, label: {
                Text("Comparable")
            })
            
            Button(action: {
                THashable()
            }, label: {
                Text("Hashable")
            })
        }
        .padding()
    }
    
    func TComparable()  {
     
        let p1 = Person(name: "A", age: 10)
        
        let p2 = Person(name: "B", age: 12)
        
        let b = p1 < p2
        
//        if b {
//            print("\(p1.name) 年龄为 \(p1.age)小于 \(p2.name)的年龄\(p2.age)")
//        } else {
//            print("\(p1.name) 年龄为 \(p1.age)不小于 \(p2.name)的年龄\(p2.age)")
//        }
        
        //
        if b {
            print("\(p1)小于 \(p2)")
        } else {
            print("\(p1)不小于 \(p2)")
        }
    }
    
    func THashable() {
        let a = Animal(name: "l")
        print(a.hashValue)
    }
}

#Preview {
    ContentView()
}
