//
//  NavigationBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2024/2/27.
//

import SwiftUI

struct NavigationBootcamp: View {
    
    var body: some View {
        NavigationView {
//            ScrollView {
                Text("Hello, Wolrd")
//            }
            .navigationTitle("导航栏标题")
            .navigationBarTitleDisplayMode(.large) //show
            .navigationBarItems(trailing: Button(action: {
                print("click trailing")
            }, label: {
                Text("Done")
            }))
            .navigationBarItems(leading: Button(action: {
                print("click leading")
            }, label: {
                Text("leading Button")
            }))
        }

    }
}

#Preview(body: {
    NavigationBootcamp()
})
