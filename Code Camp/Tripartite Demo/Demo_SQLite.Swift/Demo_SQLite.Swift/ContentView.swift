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
        
        Form {
            Button {
                sqm.inserData(username: "小明", userphone: "110", pswd: "000")
            } label: {
                Text("插入用户")
            }
            
            Button {
                sqm.deleteUser(id: 1)
            } label: {
                Text("删除用户ID为1的数据")
            }
            
            
            Button {
                sqm.updateUser(id: 1, phone: "114")
            } label: {
                Text("更新Id为0的用户 电话为114")
            }
            
            Button {
                sqm.queryUser()
            } label: {
                Text("查询Id为1的用户")
            }
            
            Button {
                sqm.queryData()
            } label: {
                Text("查询所有用户")
            }
        }
        .padding()
 
    }
}

#Preview {
    ContentView()
}
