//
//  _01_VersionOSApp.swift
//  001_VersionOS
//
//  Created by 高广校 on 2024/8/5.
//

import SwiftUI

@main
struct _01_VersionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
        
        //注册chen
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
