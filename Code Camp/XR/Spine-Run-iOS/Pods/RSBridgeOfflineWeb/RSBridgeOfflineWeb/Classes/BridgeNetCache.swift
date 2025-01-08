//
//  BridgeNetCache.swift
//  RSBridgeCache
//
//  Created by 高广校 on 2023/12/26.
//

import UIKit
import RSBridgeCore

public enum BridgeCacheAction: String , CaseIterable{
    case loadPkg
    case checkPkg
    case clearPkg
    case checkOffline
    case clearOffline //clear 
//    case setPkg
}

public class BridgeNetCache: RSBridgeInterface {
    
    lazy var netCacheManager: BridgeNetCacheManager = {
        let manager = BridgeNetCacheManager()
        return manager
    }()
    
    @discardableResult
    public init(bridgeWeVc: RSBridgeWebViewController) {
        super.init()
        webViewVc = bridgeWeVc
        for action in BridgeCacheAction.allCases {
            webViewVc?.addJShandleInterface(forKey: action.rawValue, bridgeObj: self)
        }
    }
    
    public override func jsonWebData(body: RSBridgeModel, block: @escaping JSHandleModelCallBlock) {
        super.jsonWebData(body: body, block: block)
        let action = BridgeCacheAction(rawValue:  body.action)
        
        switch action {
        case .loadPkg:
            if let jsBody = PkgModel.deserialize(from: body.data) {
                netCacheManager.loadPkg(callbackId: body.callbackId, pkgModel: jsBody, block: block)
            }
            break
        case .checkPkg:
            if let jsBody = PkgModel.deserialize(from: body.data) {
                netCacheManager.checkPkg(callbackId: body.callbackId, pkgModel: jsBody, block: block)
            }
            break
        case .clearPkg:
            if let jsBody = PkgModel.deserialize(from: body.data) {
                netCacheManager.clearPkg(callbackId: body.callbackId, pkgModel: jsBody, block: block)
            }
            break
        case .checkOffline:
            if let jsBody = PkgModel.deserialize(from: body.data) {
                netCacheManager.checkOffline(callbackId: body.callbackId, pkgModel: jsBody, block: block)
            }
            break
        case .clearOffline:
            if let jsBody = PkgModel.deserialize(from: body.data) {
                netCacheManager.clearOffline(callbackId: body.callbackId, pkgModel: jsBody, block: block)
            }
            break
//        case .request:
//            if let jsBody = BridgeRequestModel.deserialize(from: body.data) {
//                netCacheManager.request(callbackId: body.callbackId, model: jsBody, block: block)
//                netCacheManager.request(model: jsBody)
//                    .sink { state in
//                        switch state {
//                        case .finished:
//                            print("完成1")
//                        case .failure(_):
//                            print("失败1")
//                        }
//                    } receiveValue: { data in
//                        print("数据\(data)")
//                    }
//            }
            //代发请求
//            break
        case nil:
            break
        }
        
    }
}
