//
//  MirrorBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

class MirrorTestClass {
    var name: String?
    var age: Int?
    init(name: String? = nil, age: Int? = nil) {
        self.name = name
        self.age = age
    }
}

struct MirrorBootCamp: View {
    var body: some View {
        Button(action: {
            testMirror()
        }, label: {
            Text("点击")
        })
    }
    
    func testMirror()  {
        print("testMirror")
        
        let mt = MirrorTestClass(name: "herschel",age: 25)
        
        let mirror = Mirror(reflecting: mt)
        
        print("mirror is \(mirror)")
        print("mirror.subjectType is \(mirror.subjectType)")
        print("mirror.children is \(mirror.children)")
        for child in mirror.children {
            print("child.label is \(child.label!) child.value is \(child.value)")
        }
        
    }
}

#Preview {
    MirrorBootCamp()
}
