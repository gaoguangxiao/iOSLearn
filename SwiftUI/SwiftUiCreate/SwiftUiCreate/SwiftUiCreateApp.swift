//
//  SwiftUiCreateApp.swift
//  SwiftUiCreate
//
//  Created by 高广校 on 2023/11/22.
//

import SwiftUI

//`@main`标识程序的入口
@main
struct SwiftUiCreateAppOld {
    static func main() {
        if #available(iOS 14.0, *) {
            SwiftUiCreateApp.main()
        } else {
            UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(SceneDelegate.self))
        }
    }
}


@available(iOS 14.0, *)
struct SwiftUiCreateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
