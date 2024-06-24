//
//  ContentView.swift
//  Swift-Observation
//
//  Created by 高广校 on 2024/6/21.
//

import SwiftUI

/// Observation 是基于 Swift 5.9 宏系统推出的全新特性
@Observable class Person {
    var name: String = ""
}

struct ContentView: View {
    
    var perspn = Person()
    
    @State var name = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!:\(perspn.name)")
            Button(action: {
                perspn.name = "姓名"
            }, label: {
                Text("点击")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
