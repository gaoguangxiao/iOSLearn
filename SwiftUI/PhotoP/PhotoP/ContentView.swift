//
//  ContentView.swift
//  PhotoP
//
//  Created by gaoguangxiao on 2022/10/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            NavigationLink {
                PhotoAddDesView()
            } label: {
                Text("查看更多")
            }.navigationBarTitle("测试",displayMode: .large)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
