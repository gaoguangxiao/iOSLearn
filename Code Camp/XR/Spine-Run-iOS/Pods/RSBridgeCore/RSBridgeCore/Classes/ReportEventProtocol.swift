//
//  ReportEventProtocol.swift
//  RSBridgeCore
//
//  Created by 高广校 on 2024/7/15.
//

import Foundation

/// 增加上报
public protocol ReportEventProtocol {
    
    //对某个事件上报自定义错误
    func event(eventId: String, msg: String)
    
    
    /// 上报事件
    /// - Parameters:
    ///   - eventId: <#eventId description#>
    ///   - attributes: <#attributes description#>
    func event(eventId: String, attributes: Dictionary<String, Any>)
}

extension ReportEventProtocol {
    
    public func event(eventId: String, attributes: Dictionary<String, Any>) {
        
    }
  
}
