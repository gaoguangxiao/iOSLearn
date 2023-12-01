//
//  RSUtils.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/21.
//

import Foundation
import GGXSwiftExtension
import KeychainAccess

class RSUtils: NSObject{
    
    public static var deviceIdentifier: String = {
        return RSUtils.getDeviceIdentifier()
    }()
    
    /// 获取设备的UUID
    ///
    /// - Returns: UUID的字符串
    class func getUUID() -> String {
        return UUID().uuidString
    }
    
    /// 获取设备的UUID ，此UUID与BundleID绑定，为设备的唯一ID
    ///
    /// - Returns: 返回设备唯一标识符
    class func getDeviceIdentifier() -> String{
//        let bundleID : String = Bundle.main.infoDictionary?[(kCFBundleIdentifierKey as NSString) as String] as! String
        let bundleID = kAppBundleId ?? "rs.com"
        let service = bundleID + "\(#function)"
        let keychainItems = Keychain(service :service).allItems()
        var deviceID : String = ""
        if keychainItems.count > 0 {
            deviceID = keychainItems[0]["value"] as! String
        }
        if  deviceID.isEmpty {
            deviceID = getUUID()
            Keychain(service:service)["bundleID"] = deviceID
        }
        return deviceID
    }
    
    static var deviceUserAgent: String {
        var systemVersion = UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")
        var systemName = ""
        if UIDevice.isIPad {
            systemName = "OS"
        } else {
            systemName = "iPhone OS"
        }
        var newUA = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(systemName) \(systemVersion) like Mac OS X; \(UIDevice.modelName)) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
        let appVersion = kAppVersion ?? ""
        let appBuildVersion = kAppBuildVersion ?? ""
        newUA +=  " Adventure/" + appVersion + " Build/" + appBuildVersion +  " Factory/apple" + " Channel/\(getChannel)"
        UserDefaults.standard.register(defaults: ["UserAgent":newUA])
        UserDefaults.standard.synchronize()
        return newUA
    }
    
    static var getChannel: String {
        let channel = "dev"
        //        #if DEBUG
        //        #else
        //        if AppUtils.isAppStore {
        //            channel = "appstore"
        //        } else if AppUtils.isTestFlight {
        //            channel = "testflight"
        //        }
        //        #endif
        return channel
    }
    
    lazy var artScale: CGFloat = {
        let deviceHeight = SCREEN_WIDTH_STATIC
        let designedHeight = CGFloat(UIDevice.isIPad ? 768.0 : 414.0)
        return deviceHeight/designedHeight
    }()
    
    
    static var appISLandscape: Bool {
        if let tmpOrientation = UIApplication.windowScenes.first?.interfaceOrientation{
            return tmpOrientation.isLandscape
        }
        return true
    }
    
    //旋转屏幕
    static func setOrientationWithLaunchScreen(isLaunchScreen:Bool) {
//        if let app = UIApplication.shared.delegate as? AppDelegate {
//            app.orientationMask = isLaunchScreen ? .landscapeRight : .portrait
//            homepageVc.p_switchOrientationWithLaunchScreen(orientation: app.orientationMask)
//        }
    }
}
