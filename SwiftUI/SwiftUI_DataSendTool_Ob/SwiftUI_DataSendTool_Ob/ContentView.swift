//
//  ContentView.swift
//  SwiftUI_DataSendTool_Ob
//
//  Created by gaoguangxiao on 2022/9/13.
//

import SwiftUI

class UserSettings: ObservedObject {
    @Published var score = 123
}

struct ContentView: View {
    
    @EnvironmentObject var settings = UserSettings()
    
    var body: some View {
        
        NavigationView{
            
            VStack {
//                Text("人气值\(settings.score)")
                Button(action: {
//                    self.settings.score+=1
                }, label: {
                    Text("增加人气")
                })
                NavigationLink(destination: {
                    
                }, label: {
                    Text("下一个")
                })
            }
        }
        
        Text("Hello, world!")
            .padding()
        
    }
}

struct DetailView:View {
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        Text("人气值： \(settings.score)").font(.title).padding()
                    Button(action: {
                        self.settings.score += 1
                    }) {
                        Text("增加人气")
                    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
