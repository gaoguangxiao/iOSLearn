//
//  ViewBuilderBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/22.
//

import SwiftUI

extension View {
    func addRedBGWithRoundCorner() -> some View {
        self
            .padding()
            .background(.red)
            .cornerRadius(5)
    }
}

struct RedBackgroundAndCornerView<Content: View>:View {
    
    let content: Content
    
    //描述：允许闭包中提供多个子视图
    //使用ViewBuilder可以 传递多个View到闭包中，
    init(@ViewBuilder content: ()-> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(.red)
            .cornerRadius(5)
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
//        Text("Hello, World!!")
//            .padding()
//            .background(.red)
//            .cornerRadius(5)
//        
//        Image(systemName: "house.fill")
//            .padding()
//            .background(.red)
//            .cornerRadius(5)
        
        //上述代码改为
//        Text("Hello, World!!")
//            .addRedBGWithRoundCorner()
//        Image(systemName: "house.fill")
//            .addRedBGWithRoundCorner()
        
        //三、
        RedBackgroundAndCornerView {
            HStack{
                Image(systemName: "house.fill")
                Text("Hello, World!")
            }
        }
//        RedBackgroundAndCornerView {
//            Text("Hello, World!")
//            Image(systemName: "house.fill")
//        }
//       Text("globe")
        
        content
        
    }
    
    var content: some View {
        //四、条件判断
        let b: Bool = false
        if b {
            return Text("true")
        } else {
            return Text("false")
        }
    }
}


#Preview {
    ViewBuilderBootcamp()
}
