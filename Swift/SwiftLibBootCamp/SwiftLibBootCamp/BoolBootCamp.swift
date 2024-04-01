//
//  BoolBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

struct BoolBootCamp: View {
    var body: some View {
        
        Button(action: {
            randomT()
        }, label: {
            Text("随机")
        })
        
        Button(action: {
            exactlyT()
        }, label: {
            Text("精确")
        })
    }
    
    func randomT() {
        let random = Bool.random()
        print("random: \(random)")
    
       //截断
       let truncating = Bool(truncating: 0)
        print("truncating: \(truncating)")
    }
    
    func exactlyT()  {
       let exactlybool = Bool(exactly: 1)
       print("exactlybool: \(exactlybool!)")
        
        
    }
}

#Preview {
    BoolBootCamp()
}
