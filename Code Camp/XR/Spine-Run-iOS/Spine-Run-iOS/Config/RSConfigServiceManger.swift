//
//  ConfigServiceManger.swift
//  KidReading
//
//  Created by 葡萄科技 on 2019/5/9.
//  Copyright © 2019 putao. All rights reserved.
//

import UIKit
import ZKBaseSwiftProject
import RSBridgeOfflineWeb
import GGXSwiftExtension
import GXSwiftNetwork

public typealias CompletionHandler = (RSConfigiOSModel?) -> Void

public class ConfigServiceManger {
    
    public static func configServiceMangerRequest(_ completionHandler: @escaping CompletionHandler) {
        
        RSConfigApiService.share.configsiOS(params: [:]) { model in
            
            guard let dataModel = model?.ydata else {
                print("数据为空")
                completionHandler(nil)
                return
            }

            if let manifest = dataModel.manifest {
                
                //控制离线包开关
                if let enableCache = dataModel.manifest?.enableCache {
                    print("离线包开关：\(enableCache)")
                    RSWebOfflineManager.share.enable_cache = enableCache
                }

                //内容地址
                RSWebOfflineManager.share.contentManifest = manifest.contentManifest
            }
            
            /// 审锁状态
            if let phVersion = dataModel.iosVersion?.phVersion {
                PTDebugView.addLog("phVersion:\(phVersion)")
                let appVersion = kAppVersion ?? ""
                let pb = phVersion == appVersion
//                CustomUtil.setCheckSwitch(isSwitch: pb)
//                UserDefaults.U_RSENABLE = pb
            }
            
            //控制息屏策略
            if let osWakeTime = dataModel.osWakeTime {
//                UserDefaults.idleOsWakeTime = osWakeTime
            }
            
            // add lateset header
            if let latest = dataModel.iosVersion?.latest {
                MSBApiConfig.shared.appendHeader(["latestVersion":latest])
            }
            //存储initUrl
//            dataModel.manifest?.initialUrl =
            completionHandler(dataModel)
        }
        //        ConfigService().request("api/v1/configs/ios", httpMethod: nil, params: nil) { (statues) in
        //            switch statues {
        //            case .DidSuccess(let json) :
        //                if let json = json , json["code"].int == 0 {
        
        // 更新config数据
        //                    PTGlobalConfig.share.update(json)
        
        // 版本更新
        //                    let ios_version : [String:Any]? = json["data"]["ios_version"].dictionaryObject
        //                    PTVersionUpdateTool.handleVersionUpdate(ios_version)

        // 检查更新 inital_url
        //                    if let inital_url: String = json["data"]["manifest"]["initial_url"].string {
        //                        PTConfig.share.updateBaseUrl(inital_url , reloadWebview: !PTConfig.share.launchFromPush )
        //                    }
        //
        //                    if let sid_expire_time : Int64 = json["data"]["sid_expire_time"].int64 ,  sid_expire_time > 0 {
        //                        PTTrackerManager.share.updateTrackItem(.SidExpireTime(sid_expire_time))
        //                    }
        //
        //                    if  let _os_wake_time : Int = json["data"]["os_wake_time"].int , _os_wake_time > 0 {
        //                        os_wake_time = _os_wake_time
        //                    }
        //                    if let os_uri_white_list: [String] = json["data"]["os_uri_white_list"].arrayObject as? [String] {
        //                        PTConfig.share.updateWhiteUrlSchemes(urlList: os_uri_white_list)
        //                    }
        //
        //                    if let secure_web_url_pattern: String = json["data"]["secure_web_url_pattern"].string {
        //                        PTConfig.share.updateWebViewUrlWhiteList(info: secure_web_url_pattern)
        //                    }
        //                    // 是否开启语音验证码功能 voice_verify_ability 为true 开启
        //                    if let voice_verify_ability = json["data"]["login_verify"]["voice_verify_ability"].bool {
        //                        UserDefaults.VoiceSms.set(value: String(voice_verify_ability), forKey: .isOpen)
        //                    }
        //
        //                    if let pb = json["data"]["pb_enable"].bool {
        //                        if pb == false {
        //                            UserDefaults.LoginInfo.set(value: "false", forKey: .protocolSelect)
        //                        }
        //                        PTTrackerManager.share.pb_enable = pb ? .Usable : .Forbidden
        //                        PTUserDefaultManager.userDefaults.setCheckSwitch(isSwitch: pb)
        //                    }
        //
        //                    completionHandler(.DidSuccess(json))
        //                }
        //            case .DidFaild :
        //                completionHandler(.DidFaild)
        //                break;
        //            }
        //        }
    }
    
    
}
