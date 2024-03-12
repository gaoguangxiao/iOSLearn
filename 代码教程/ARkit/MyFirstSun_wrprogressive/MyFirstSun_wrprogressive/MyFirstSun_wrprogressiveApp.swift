//
//  MyFirstSun_wrprogressiveApp.swift
//  MyFirstSun_wrprogressive
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI

@main
struct MyFirstSun_wrprogressiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
