//
//  ContentView.swift
//  Demo_SQLite.Swift
//
//  Created by 高广校 on 2024/11/1.
//

import SwiftUI

struct ContentView: View {
    
    let sqm = SQLiteManager()
    
    var body: some View {
        VStack {
            
            Button {
                sqm.inserData(username: "小明", userphone: "110", pswd: "000")
            } label: {
                Text("插入用户")
            }
            
            Button {
                sqm.queryData()
            } label: {
                Text("查询所有用户")
            }
            
            Button {
                sqm.queryUser()
            } label: {
                Text("查询Id为0的用户")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
