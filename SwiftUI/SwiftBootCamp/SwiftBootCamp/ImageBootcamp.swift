//
//  ImageBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/21.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        //        resizable 有两个参数可以调整`capInsets`大小
        //        resizingMode：渲染模式
        //        `stretch`：拉伸方式
        //        `tile`：瓦片方式，
                    Image("Userbg")
                    .resizable()
        //            .interpolation(.none)
        //            .resizable(capInsets: /*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/,resizingMode: .stretch)
        //            .frame(width: 100,height: 100)
//                    .aspectRatio(contentMode: .fill)
        //            .clipShape(Capsule())
                    .shadow(color: .red, radius: 10)
        //            if #available(iOS 15.0, *) {
        //                .overlay {
        //                    Text("Overlay")
        //                }
        //            } else {
        //                // Fallback on earlier versions
        //            }
    }
}

#Preview {
    ImageBootcamp()
}
