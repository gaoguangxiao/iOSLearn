//
//  AppStoregeBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/25.
//

import SwiftUI

struct AppStoregeBootcamp: View {
    
//    @State var currentUserName: String?
    @AppStorage("name") var currentUserName: String?
    
    var body: some View {
        VStack {
            
            Text("用户名:\(currentUserName ?? "Add User name")")
         
            if let name = currentUserName {
                Text("用户名:\(name)")
            }
            
            Button(action: {
                currentUserName = "高广校"
                
//                UserDefaults.standard.setValue(currentUserName, forKey: "name")
            }, label: {
                Text("保存")
            })
            
            Button(action: {
                currentUserName = "高校"
//                UserDefaults.standard.setValue(currentUserName, forKey: "name")
            }, label: {
                Text("保存")
            })
            
            Button(action: {

//                UserDefaults.standard.setValue(nil, forKey: "name")
//                UserDefaults.standard.synchronize()
                
                currentUserName = ""
                
            }, label: {
                Text("移除")
            })
            
        }.onAppear(perform: {

//            if let name = UserDefaults.standard.value(forKey: "name") {
//                currentUserName = name as? String
//            }
            
        })
    }
}

#Preview {
    AppStoregeBootcamp()
}
