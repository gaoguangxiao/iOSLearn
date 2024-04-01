//
//  EquatableBootCamo.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

// 结构体遵循`Equatable`协议，可以不用实现`==`方法，默认将struct实例中所有属性对比结构
struct EquatableStuct: Equatable {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
}

class EquatableCalss: Equatable {
    static func == (lhs: EquatableCalss, rhs: EquatableCalss) -> Bool {
        return lhs.value == rhs.value
    }
    
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

struct EquatableBootCamo: View {
    var body: some View {
        
        VStack(spacing: 10, content: {
  
            Button(action: {
                
                structEquat()
            }, label: {
                Text("struct相等")
            })
            
            Button(action: {
                
                classEquat()
            }, label: {
                Text("class相等")
            })
        })
    }
    
    func structEquat() {
        let a = EquatableStuct(value: 10)
        let b = EquatableStuct(value: 10)
        print("struct equata \(a == b)")
    }
    
    func classEquat() {
        let a = EquatableCalss(value: 10)
        let b = EquatableCalss(value: 10)
        print("class equata ==  \(a == b)")
        
        // `===`是实例指针的对比
        print("class equata === \(a === b)")
    }
}

#Preview {
    EquatableBootCamo()
}
