//
//  ContentView.swift
//  SwiftUI_DataSendTool
//
//  Created by gaoguangxiao on 2022/9/12.
//  @binding 和 @State的使用

import SwiftUI

//定义一个计数的按钮
struct CountButton : View {
    //用binding修饰的属性，子视图对值进行修改之后会影响 父视图，此属性就变为引用类型，传递的是指针地址
    @Binding var bCount : Int
    var body: some View {
        Button(action: {
            bCount = bCount + 1
        }, label: {
            Text("改变计数")
        })
    }
}

//内容视图
struct ContentView: View {
    @State private var count : Int = 0
    var body: some View {
        Text("Hello, world!\(count)")
            .padding()
        CountButton(bCount: $count)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
