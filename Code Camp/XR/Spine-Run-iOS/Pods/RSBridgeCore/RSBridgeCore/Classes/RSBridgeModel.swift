//
//  RSBridgeModel.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/13.
//

import UIKit
import SmartCodable
import GGXSwiftExtension

//增加泛型解析data的类型
/*`参数paramsModel`是对`params`的解析，遵守`SmartCodable`协议
   属性`data`的数据类型并不固定，利用泛型，且遵守`SmartCodable`协议
**/

public struct RSParamsModel<T>: SmartCodable where T: SmartCodable {
    public var action: String = ""
    public var callbackId: Int = 0
    public var data: T?
    public init() {}
}

public struct JSBodyModel: SmartCodable {
    
    public var params: JSParamsModel?
 
    public init() {}
}

//手写解析库
public struct JSParamsModel: SmartCodable {
    
    public var action: String = ""
    public var callbackId: Int = 0
    
    @SmartAny
    public var data: Any?
    
    public var dataDict: [String: Any] {
        return data as? Dictionary ?? [:]
    }
    
    public init() {}
}

public class RSBridgeMsgBodyModel {
    public var params : RSBridgeModel?
}

public class RSBridgeModel: NSObject {
    public var action : String = "" //动作
    public var callbackId : Int = 0
    public var data : Dictionary<String, Any> = [:]
    public var code = 0
    public var msg = ""
    
    public var dataFiltKeys: Array<String> = []
    
    required public override init() {
        super.init()
        //        fatalError("init() has not been implemented")
    }
    
    public init(_ callbackId: Int,code:Int = 0,msg:String = "",data: Dictionary<String, Any> = [:]) {
        super.init()
        self.callbackId = callbackId
        self.code = code
        self.msg  = msg
        self.data = data
    }
    
    public init(callbackId: Int?,code:Int = 0,msg:String = "",data: Dictionary<String, Any> = [:]) {
        super.init()
        self.callbackId = callbackId ?? 0
        self.code = code
        self.msg  = msg
        self.data = data
    }
    
    public init(action: String, code:Int = 0,msg:String = "",data: Dictionary<String, Any> = [:]) {
        super.init()
        self.action = action
        self.code = code
        self.msg  = msg
        self.data = data
    }
    
    /// 自定义json描述
    public override var description: String {
        
        var newLogData: Dictionary<AnyHashable, Any> = [:]
        
        newLogData = data.filter { (key,value) in
            return !dataFiltKeys.contains(key)
        }
        
//        newLogData["data"] = newDa
        
        let dict :[String:Any] = ["action": action, "data":newLogData, "callbackId":callbackId , "code" : code , "msg":msg];
        if let signedJSON = dict.toJsonString {
            return signedJSON
        }
        return super.description
    }
}
