//
//  RSBridgeInterface.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/15.
//

import UIKit

open class RSBridgeInterface: NSObject, RSBridgeProtocol {
    
    public var bridgeRespTimes: Dictionary<Int, Double> = [:]
    
    public var webViewVc: RSBridgeWebViewController?
    
    public var bridgeCore: iOSBridgeCore?
    public override init() {
        
    }
    
    public init(_ webVc: RSBridgeWebViewController) {
        super.init()
        webViewVc = webVc
    }
    
    public init(_ bridge: iOSBridgeCore) {
        super.init()
        bridgeCore = bridge;
    }
    
    open func jsonWebData(body: RSBridgeModel, block: @escaping JSHandleModelCallBlock) {
        //        ZKLog("\(self)执行\(body.actionE)")
    }
    
    open func bridgeWebData(body: JSParamsModel, block: @escaping JSHandleModelCallBlock) {

    }
    
    @available(iOS 13.0.0, *)
    @discardableResult
    open func bridgeWebCallApp<T>(body: JSParamsModel, data: T) async throws -> RSBridgeModel {
        bridgeRespTimes[body.callbackId] = CFAbsoluteTimeGetCurrent()
        return RSBridgeModel()
    }
    
    //向JS通信
    public func evenCallWeb(_ body: RSBridgeModel) {
        webViewVc?.callJS(body: body)
    }
}
