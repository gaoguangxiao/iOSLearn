//
//  MyFirstVolume_NoneApp.swift
//  MyFirstVolume-None
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI

@main
struct MyFirstVolume_NoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
        
        //定义Id，
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
