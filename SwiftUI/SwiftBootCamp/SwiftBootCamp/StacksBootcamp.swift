//
//  StacksBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/21.
//

import SwiftUI

struct StacksBootcamp: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(.red)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
            
            Rectangle()
                .fill(.orange)
                .frame(width: 100,height: 100)
            
            Rectangle()
                .fill(.yellow)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
        }
        
//        ZStack {
//            Rectangle()
//                .fill(.red)
//                .frame(width: 150,height: 150)
//            
//            Rectangle()
//                .fill(.orange)
//                .frame(width: 130,height: 130)
//            
//            Rectangle()
//                .fill(.yellow)
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
//        }
    }
}

#Preview {
    StacksBootcamp()
}
