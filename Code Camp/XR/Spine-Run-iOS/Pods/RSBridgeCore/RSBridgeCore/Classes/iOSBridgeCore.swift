//
//  iOSBridgeCore.swift
//  Unity-iPhone
//
//  Created by 高广校 on 2024/8/16.
//

import Foundation
import ZKBaseSwiftProject
import SmartCodable
import PTDebugView

@objcMembers
public class iOSBridgeCore: NSObject  {
    
    public static let instance = iOSBridgeCore()
    
    public var jsInterfaceMap: [String: RSBridgeInterface] = [:]
    
    //action: [交互name: (交互协议、模型)]
    public var jsActionModelMap: [String: (RSBridgeProtocol, SmartCodable.Type)] = [:]
    
    /// 对data中key进行过滤
//    public var dataFiltKeys: Array<String> = []
    
    open var supportsBackgroundJS: Bool = true  // 默认为支持后台 JS
    
    public var savedBridgeEvents: [JSParamsModel] = []  //用于存储app位于后台时的 JS 事件
    
    let eventBridgeQueue = DispatchQueue(label: "com.adventure.eventBridgeQueue")  // 串行队列，避免并发冲突

    //
    var webViewVc: RSBridgeWebViewController?
    
    @available(iOS 13.0, *)
    public func handleWebCallApp(bodyS: JSParamsModel) {
        
        let action = bodyS.action
        
        if let interface = self.jsInterfaceMap[action] {
            let objB  = RSBridgeModel()
            objB.callbackId = bodyS.callbackId;
            objB.action = bodyS.action;
            objB.data = bodyS.dataDict;
            interface.jsonWebData(body: objB) { callBody in
                self.webViewVc?.callJS(body: callBody)
            }
        }
        
        if let interfaceS = self.jsInterfaceMap[action] {
            interfaceS.bridgeWebData(body: bodyS) { callBody in
                self.webViewVc?.callJS(body: callBody)
            }
        }
        
        if var (interfaceS, Model) = jsActionModelMap.filter({ $0.key == action }).first?.value {
            let jsBody = Model.deserialize(from: bodyS.dataDict)
            Task {
                do {
                    let model = try await interfaceS.bridgeWebCallApp(body: bodyS, data: jsBody)
                    interfaceS.removeBridgeRespTime(forID: bodyS.callbackId)
                    await self.webViewVc?.callJS(body: model)
                } catch let error {
                    if let coreError = error as? BridgeRespError<CoreError> {
                        await self.webViewVc?.callJS(body: CallWeb(bodyS.callbackId,code: coreError.code,msg: coreError.errorString))
                    } else {
                        await self.webViewVc?.callJS(body: CallWeb(bodyS.callbackId,code: -1,msg: error.localizedDescription))
                    }
                }
            }
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
        
        if !supportsBackgroundJS, isAppInBackground(){
            saveJsEvents(bodyS)
            return
        }

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

//增加js事件后台存储
extension iOSBridgeCore {
    
    //保存JS事件
    public func saveJsEvents(_ body: JSParamsModel) {
        PTDebugView.addLog("已添加后台 JS 任务" + (body.toJSONString() ?? ""))
        eventBridgeQueue.sync {
            savedBridgeEvents.append(body)
        }
    }
    
    // App进入前台，重新执行JS事件的通知
    public func executeJsEvents() {
        guard !supportsBackgroundJS else {
            // 如果不支持后台 JS，直接返回
            print("支持后台 JS，不保存后台任务")
            return
        }
        
        eventBridgeQueue.sync {
            for event in savedBridgeEvents {
                PTDebugView.addLog("执行保存的 JS 事件" + (event.toJSONString() ?? ""))
                if #available(iOS 13.0, *) {
                    iOSBridgeCore.instance.handleWebCallApp(bodyS: event)
                } else {
                    // Fallback on earlier versions
                }
            }
            // 清空事件列表
            savedBridgeEvents.removeAll()
        }
    }
    
    // 判断应用是否在后台
    func isAppInBackground() -> Bool {
        return UIApplication.shared.applicationState == .background
    }
}
