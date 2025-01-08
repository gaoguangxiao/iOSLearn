//
//  BridgeRespError.swift
//  RSBridgeCore
//
//  Created by 高广校 on 2024/7/24.
//  定义错误协议，通用

import Foundation

/// 错误类型描述
/// 遵循`RawRepresentable`是为了让自定义枚举，实现原始值
public protocol BridgeErrorProtocol: RawRepresentable {
    
    var errorString: String { get }
}

public enum BridgeRespError<T: BridgeErrorProtocol>: Error {
    /// 对应模块自定义类型code
    case type(_ value: T)
    
    /// 基类请求code
    case baseType(_ value: CoreError)
    
    /// 错误提示归整
    public var errorString: String {
        switch self {
        case .type(let value):
            return value.errorString
        case .baseType(let value):
            return value.errorString
        }
    }
    
    public var peel: any BridgeErrorProtocol {
        switch self {
        case .type(let value):
            return value
        case .baseType(let value):
            return value
        }
    }
    
    public var code: Int {
        if let value = peel.rawValue as? Int { value }
        else { -1 }
    }
}

//MARK: - 通用

/// web -> App 产生的错误，如`data`空，`action`不合理
///
public enum CoreError: Int, BridgeErrorProtocol {
    case success
    case unknown
    case actionUnknown // action未知
    case dataEmpty // data为空
    public var errorString: String {
        switch self {
        case .success: "成功"
        case .unknown: "未知"
        case .actionUnknown: "action未知"
        case .dataEmpty: "data为空"
        }
    }
}
//MARK: 接口错误
public enum BridgeApiError:Int, BridgeErrorProtocol {
    case configError
    case unknown
    public var errorString: String {
        switch self {
        case .configError:
            "接口调用失败"
        case .unknown:
            "未知"
        }
    }
}

//MARK: 音频
public enum BridgeAudioError: Int, BridgeErrorProtocol {
    
    case pathNotFound = 1
    case textNotFound
    case unknown
    case audioSessionError
    
    public var errorString: String {
        switch self {
        case .pathNotFound: "`path`不存在"
        case .textNotFound: "`text`不存在"
        case .unknown: "未知"
        case .audioSessionError: "AudioSession配置失败"
        }
    }
}

//MARK: 语言合成


