//
//  RSBaseInterfaceProtocol.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/14.
//

import UIKit
import PTDebugView

public typealias CallWeb = RSBridgeModel

public typealias JSHandleModelCallBlock = (_ callBody: RSBridgeModel)->Void

//
public typealias RSBridgeProtocol = RSBridgeRequestProtocol & RSBridgeResponseProtocol

public protocol RSBridgeInterfaceProtocol {
    
    var webViewVc: RSBridgeWebViewController? { get set }
    
    //记录每个bridge响应时间，请求记录，响应移除
    var bridgeRespTimes: Dictionary<Int, Double> {set get}
}

///bridge请求
public protocol RSBridgeRequestProtocol: RSBridgeInterfaceProtocol {
    
    func jsonWebData(body: RSBridgeModel, block: @escaping JSHandleModelCallBlock)
    
    
    func bridgeWebData(body: JSParamsModel, block: @escaping JSHandleModelCallBlock)
    
    /// 解析web -> App的bridge请求
    @available(iOS 13.0.0, *)
    @discardableResult
    func bridgeWebCallApp<T>(body: JSParamsModel, data: T) async throws -> RSBridgeModel
}

/// 响应协议
public protocol RSBridgeResponseProtocol: RSBridgeInterfaceProtocol {
    
    /// app对web的主动调用
    /// - Parameters:
    ///   - action: 调用方法
    ///   - data: 传递数据
    ///   - msg: 错误信息
    func onCallWeb(action: String, data: Dictionary<String, Any>?)
    
    
    /// app对web调用-错误抛出
    /// - Parameters:
    ///   - action: <#action description#>
    ///   - data: <#data description#>
    ///   - code: <#code description#>
    ///   - msg: <#msg description#>
    func onCallWebError(action: String, data: Dictionary<String, Any>?, code: Int, msg: String)
    
    
    /// app对web调用，统一处理
    /// - Parameter body: <#body description#>
    func evenCallWeb(_ body: RSBridgeModel)
}

extension RSBridgeResponseProtocol {
    
    public func onCallWeb(action: String, data: Dictionary<String, Any>? = nil) {
        let bridge = RSBridgeModel()
        bridge.action = action
        if let data {
            bridge.data = data
        }
        evenCallWeb(bridge)
    }
    
    public func onCallWebError(action: String, data: Dictionary<String, Any>? = nil, code: Int = -1, msg: String) {
        let bridge = RSBridgeModel()
        bridge.action = action
        if let data {
            bridge.data = data
        }
        bridge.code = code
        bridge.msg = msg

        webViewVc?.callJS(body: bridge)
        webViewVc?.event(eventId: bridge.action, attributes: ["error":msg])
    }

    //
    public mutating func removeBridgeRespTime(forID callbackID: Int) {
        if let startReceiveTime = bridgeRespTimes[callbackID] {
            let timeInterval = CFAbsoluteTimeGetCurrent() - startReceiveTime
            ZKLog("`\(callbackID)`的响应时间: \(timeInterval * 1000)毫秒")
        }
        self.bridgeRespTimes.removeValue(forKey: callbackID)
    }
    
    public func evenCallWeb(_ body: RSBridgeModel) {
        webViewVc?.callJS(body: body)
        
        webViewVc?.event(eventId: body.action, msg: body.description)
    }
}
