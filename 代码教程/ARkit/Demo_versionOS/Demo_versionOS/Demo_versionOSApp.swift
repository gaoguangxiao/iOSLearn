//
//  Demo_versionOSApp.swift
//  Demo_versionOS
//
//  Created by 高广校 on 2024/2/18.
//

import SwiftUI

@main
struct Demo_versionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
