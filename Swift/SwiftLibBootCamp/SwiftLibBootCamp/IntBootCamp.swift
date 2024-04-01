//
//  IntBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

struct IntBootCamp: View {
    var body: some View {
        Button(action: {
            intT()
        }, label: {
            Text("点击")
                .foregroundColor(.red)
        })
    }
    
    func intT()  {

        var i = Int()
        i = 12
        print("i: \(i)")
        
        let loseInt = Int(-12.4)
        let uin = UInt(12)
        
    }
}

#Preview {
    IntBootCamp()
}
