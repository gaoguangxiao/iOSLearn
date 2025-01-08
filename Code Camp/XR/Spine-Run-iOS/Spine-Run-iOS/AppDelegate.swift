//
//  AppDelegate.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/14.
//

import UIKit
import SwiftUI
import GXSwiftNetwork
import GGXSwiftExtension
import PTDebugView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func initConfig() {
        ZKWLog.init()
        
        var header: [String: String] = [:]
        header["device"] = "app"
        header["os-type"] = "ios"
        header["version"] = "\(kAppVersion ?? "1.0")"//1.6.3
        header["device-model"] = UIDevice.modelName
        if (UIDevice.isIPad) {
            header["device-type"] = "iPad"
        }else {
            header["device-type"] = "iPhone"
        }
//    https://gateway-test.risekid.cn
//    https://gw.risekid.cn
        MSBApiConfig.shared.setApiConfig(apiHost: "https://gw.risekid.cn",
                                         commonHeaders: header,
                                         isAddDefaultHeaders: true)
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

