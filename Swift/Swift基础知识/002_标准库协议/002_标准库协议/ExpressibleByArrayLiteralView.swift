//
//  ExpressibleByArrayLiteral.swift
//  002_标准库协议
//
//  Created by 高广校 on 2024/3/28.
//

import SwiftUI

struct PersonA: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = Any
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        
        var name: String = ""
        
        if let nm = elements.first as? String {
            name = nm
        }
        
        var age: Int = 0
        
        if let _age = elements[1] as? Int {
            age = _age
        }
        self.init(name: name, age: age)
    }
}

struct ExpressibleByArrayLiteralView: View {
    var body: some View {
        Button(action: {
            let p = PersonA(arrayLiteral: "aaaa",100)
            print(p)
//            Literal
            
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    ExpressibleByArrayLiteralView()
}
