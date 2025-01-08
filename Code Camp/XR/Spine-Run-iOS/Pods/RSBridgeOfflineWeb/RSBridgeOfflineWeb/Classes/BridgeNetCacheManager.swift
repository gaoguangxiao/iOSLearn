//
//  BridgeNetCacheManager.swift
//  RSBridgeCache
//
//  Created by 高广校 on 2023/12/26.
//

import Foundation
import RSBridgeCore

class BridgeNetCacheManager: NSObject {
    
    lazy var webOfflineManager: RSWebOfflineManager = {
        let manager = RSWebOfflineManager()
        return manager
    }()
    
    var pkgManager: RSWebOfflineManager?
    
    func loadPkg(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock)  {
        
        guard let type = pkgModel.type else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源类型(type)必须"))
            return
        }
        
        guard let item = pkgModel.item else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源(item)必须"))
            return
        }
        
        let progressAction = pkgModel.progressAction
        
        guard let content_manifest = RSWebOfflineManager.share.contentManifest else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "(contentMainFest未获取到)必须"))
            return
        }
        
        let url = content_manifest.replacingOccurrences(of: "{type}", with: type).replacingOccurrences(of: "{item}", with: item)
        pkgManager = RSWebOfflineManager()
        pkgManager?.requestForLoadManifestAndResource(url: url) { totalCount,loaderCount, state in
            let bridge = CallWeb()
            bridge.code = 0
            //            bridge.action = "downloadEvent"
            switch state {
            case .completed:
                //                bridge.data = ["event":"completed"]
                self.pkgManager = nil
                block(CallWeb(callbackId: callbackId))
            case .started:
                print("准备下载")
                //                bridge.data = ["event":"started"]
                //                block(bridge)
            case .paused:
                //                bridge.data = ["event":"paused"]
                //                block(bridge)
                print("paused")
            case .notStarted:
                //                bridge.data = ["event":"notStarted"]
                //                block(bridge)
                print("notStarted")
            case .stopped:
                //                bridge.data = ["event":"stopped"]
                //                block(bridge)
                print("stopped")
            case .downloading:
                guard let progressAction else { return }
                bridge.action = progressAction
                bridge.data = ["total" : totalCount,"loaded" : loaderCount]
                block(bridge)
                //                self.callJS(action: progressAction, callbackId: 0,data: ["total" : totalCount,"loaded" : loaderCount])
                //                print("bridge传递的下载进度:\(loaderCount/totalCount)")
                break
            case .error:
                //                bridge.data = ["event":"error"]
                bridge.callbackId = callbackId
                bridge.code = 1
                block(bridge)
                self.pkgManager = nil
                print("异常")
                //                block(CallWeb(callbackId: callbackId,code: 1))
            }
        }
    }
    
    func checkPkg(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock)  {
        
        guard let type = pkgModel.type else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源类型(type)必须"))
            return
        }
        
        guard let item = pkgModel.item else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源(item)必须"))
            return
        }
        
        guard let content_manifest = RSWebOfflineManager.share.contentManifest else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "(contentMainFest未获取到)必须"))
            return
        }
        
        let cacheKey = pkgModel.cacheKey ?? content_manifest
        
        let url = content_manifest.replacingOccurrences(of: "{type}", with: type).replacingOccurrences(of: "{item}", with: item)
        webOfflineManager.checkIfManifestExsit(url: url, resManifestName: cacheKey) { (code) in
            block(CallWeb(callbackId: callbackId,code: code))
        }
    }
    
    func clearPkg(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock) {
        //
        if let type = pkgModel.type ,
            let item = pkgModel.item ,
           let content_manifest = RSWebOfflineManager.share.contentManifest {
            
            let url = content_manifest.replacingOccurrences(of: "{type}", with: type).replacingOccurrences(of: "{item}", with: item)
            
            webOfflineManager.removePkg(url: url) { b in
                block(CallWeb(callbackId: callbackId,code: b ? 0: 1))
            }
            
        } else {
            
            let b = webOfflineManager.removeAll()
            block(CallWeb(callbackId: callbackId,code: b ? 0: 1))
            
        }
    }
    
    func clearOffline(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock) {
        let b = webOfflineManager.removeAllOfline(path: pkgModel.folderName)
        block(CallWeb(callbackId: callbackId,code: b ? 0: 1))
    }
    
    func checkOffline(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock) {
        //
        if let cacheKey = pkgModel.cacheKey {
            if let _ = RSWebOfflineManager.share.requestOfflinePathWith(url: cacheKey){
                
                block(CallWeb(callbackId: callbackId,code:0))
            } else {
                block(CallWeb(callbackId: callbackId,code:1,msg: "无"))
            }
        } else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "传入cacheKey"))
        }
    }
}
