//
//  BridgeNetCacheManager.swift
//  RSBridgeCache
//
//  Created by 高广校 on 2023/12/26.
//

import Foundation
import RSBridgeCore
import PTDebugView

class BridgeNetCacheManager: NSObject {
    
//    lazy var webOfflineManager: BridgeNetDownloadManager = {
//        let manager = BridgeNetDownloadManager()
//        return manager
//    }()
    
    var pkgManager: BridgeNetDownloadManager?
    
    func loadPkg(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock)  {
        
        guard let type = pkgModel.type else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源类型(type)必须"))
            return
        }
        
        guard let item = pkgModel.item else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "资源(item)必须"))
            return
        }
        
        guard let progressAction = pkgModel.progressAction else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "进度(progressAction)必须"))
            return
        }
        
        guard let content_manifest = RSWebOfflineManager.share.contentManifest else {
            block(CallWeb(callbackId: callbackId,code: 1,msg: "(contentMainFest未获取到)必须"))
            return
        }
        
        let url = content_manifest.replacingOccurrences(of: "{type}", with: type).replacingOccurrences(of: "{item}", with: item)
        pkgManager = BridgeNetDownloadManager()
        pkgManager?.requestForLoadManifestAndResource(url: url) { totalCount,loaderCount,loaderSize,totalSize, state in
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
                bridge.action = progressAction
                bridge.data = ["total" : totalCount,
                               "loaded" : loaderCount,
                               "loadedSize":loaderSize,
                               "totalSize":totalSize]
                block(bridge)
                break
            case .error:
                //                bridge.data = ["event":"error"]
                bridge.callbackId = callbackId
                bridge.code = 1
                block(bridge)

                self.pkgManager = nil
                PTDebugView.addLog("loadpkg error:\(callbackId)")
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
        pkgManager = BridgeNetDownloadManager()
        pkgManager?.checkIfManifestExsit(url: url, resManifestName: cacheKey) { (code) in
            block(CallWeb(callbackId: callbackId,code: code))
            self.pkgManager = nil
        }
    }
    
    func clearPkg(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock) {
        pkgManager = BridgeNetDownloadManager()
        if let type = pkgModel.type ,
            let item = pkgModel.item ,
           let content_manifest = RSWebOfflineManager.share.contentManifest {
            
            let url = content_manifest.replacingOccurrences(of: "{type}", with: type).replacingOccurrences(of: "{item}", with: item)
            
            pkgManager?.removePkg(url: url) { b in
                block(CallWeb(callbackId: callbackId,code: b ? 0: 1))
            }
            
        } else {
            _ = pkgManager?.removeAll()
            block(CallWeb(callbackId: callbackId,code: 0))
        }
    }
    
    func clearOffline(callbackId:Int,pkgModel:PkgModel,block: @escaping JSHandleModelCallBlock) {
        pkgManager = BridgeNetDownloadManager()
        let _ = pkgManager?.removeAllOfline(path: pkgModel.folderName)
        block(CallWeb(callbackId: callbackId,code: 0))
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
