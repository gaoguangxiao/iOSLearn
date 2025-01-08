//
//  iOSBridgeCore.swift
//  Unity-iPhone
//
//  Created by 高广校 on 2024/8/16.
//

import Foundation
import ZKBaseSwiftProject
import SmartCodable

@objcMembers
public class iOSBridgeCore: NSObject  {
    
    public static let instance = iOSBridgeCore()
    
    public var jsInterfaceMap: [String: RSBridgeInterface] = [:]
    
    //action: [交互name: (交互协议、模型)]
    public var jsActionModelMap: [String: (RSBridgeProtocol, SmartCodable.Type)] = [:]
    
    /// 对data中key进行过滤
    public var dataFiltKeys: Array<String> = []
    
    @available(iOS 13.0, *)
    public func handleWebCallApp(name:String,
                                 params: String,
                                 block: @escaping JSHandleModelCallBlock) {
        PTDebugView.addLog("CallApp:" + "\(params)")
        switch name {
        case "postMessage":
            handleCallApp(params: params, block: block)
            break
        default:
            return
        }
    }
    
    /// Process parameters from outside
    /// - Parameters:
    ///   - params: <#params description#>
    ///   - block: <#block description#>
    @available(iOS 13.0, *)
    public func handleCallApp(params: String,
                              block: @escaping JSHandleModelCallBlock) {
        let jsBodyS = JSBodyModel.deserialize(from: params)
        guard let bodyS = jsBodyS?.params else { return }
        let action = bodyS.action
        
        if let interface = self.jsInterfaceMap[action] {
            let objB  = RSBridgeModel()
            objB.callbackId = bodyS.callbackId;
            objB.action = bodyS.action;
            objB.data = bodyS.dataDict;
            interface.jsonWebData(body: objB, block: block)
        }
        
        if let interfaceS = self.jsInterfaceMap[action] {
            interfaceS.bridgeWebData(body: bodyS, block: block)
        }
        
        if var (interfaceS, Model) = jsActionModelMap.filter({ $0.key == action }).first?.value {
            let jsBody = Model.deserialize(from: bodyS.dataDict)
            Task {
                do {
                    let model = try await interfaceS.bridgeWebCallApp(body: bodyS, data: jsBody)
                    interfaceS.removeBridgeRespTime(forID: bodyS.callbackId)
                    block(model)
                    
                } catch let error {
                    if let coreError = error as? BridgeRespError<CoreError> {
                        block(CallWeb(bodyS.callbackId,code: coreError.code,msg: coreError.errorString))
                    } else {
                        block(CallWeb(bodyS.callbackId,code: -1,msg: error.localizedDescription))
                    }
                }
            }
        }
    }
    
}

extension iOSBridgeCore {
    
    func registerBridge()  {
        //合成
    }
    
    public func addJShandleInterface(forKey key: String,bridgeObj: RSBridgeInterface) {
        self.jsInterfaceMap[key] = bridgeObj
    }
    
    ///传入action对应的解析模型，使用类的类型，而非实例
    public func addJShandleInterface<Model>(forKey key: String,
                                            bridgeObj: RSBridgeProtocol,
                                            modelType: Model.Type) where Model: SmartCodable {
        self.jsActionModelMap[key] = (bridgeObj, modelType)
    }
}
