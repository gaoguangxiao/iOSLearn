//
//  ZKBaseBridgeWebViewController.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/12.
//

import UIKit
import WebKit
import GGXSwiftExtension
import ZKBaseSwiftProject
import SmartCodable
import RxCocoa
import PTDebugView
import AVFAudio

@objcMembers
open class RSBridgeWebViewController: ZKBaseWKWebViewController, ReportEventProtocol {

    /// 对data中key进行过滤
    public var dataFiltKeys: Array<String> = []
    // 对data中包含的key-value值 匹配不打印
    public var dataNoPrintKeysAndValue: Array<String> = []
    // 对data中包含的key不打印日志
    public var dataNoPrintKeys: Array<String> = []
    // 对data中包含的value的值不打印日志
    public var dataNoPrintValue: Array<String> = []
    
    //app是否退入后台
    public var appForEnterBackground: Bool = false
    
    open override func viewDidAppear(_ animated: Bool) {
//        self.callJS(action: "webViewShow")
        self.callJS(body: CallWeb(action: "webViewShow"))
        super.viewDidAppear(animated)
    }
    
    public var supportsBackgroundJS = true {
        didSet {
            iOSBridgeCore.instance.supportsBackgroundJS = supportsBackgroundJS
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
//        self.callJS(action: "webViewHide")
        self.callJS(body: CallWeb(action: "webViewHide"))
        super.viewDidDisappear(animated)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.insertSubview(backImageView, belowSubview: self.webView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iOSBridgeCore.instance.webViewVc = self
        
        self.addUserScript(forSource: jsCode)
        
        self.scriptMessageDelegate = self
        self.addScriptMessage(name: "postMessage")
        
        self.registerObserver()
    }
    
    open override func buildUI() {
        super.buildUI()
        webView.snp.updateConstraints { make in
            make.top.equalTo(0)
        }
    }
    
    var jsCode: String {
        get {
            return """
            var nativeBridge = new Object();
            nativeBridge.postMessage = function(params) {
            return window.webkit.messageHandlers.postMessage.postMessage({params});
            }
            """
        }
    }
    
    public lazy var backImageView: UIImageView = {
        let imageView = UIImageView.init()
        //        imageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    public func resetAudioSession() throws {
        if UserDefaults.record {
            try AVAudioSession.configureAudioSessionForPlayAndRecord()
        } else {
            try AVAudioSession.configureAudioSessionForPlayback()
        }
    }
    
    open func callJS(body: RSBridgeModel) {
        addLog(body)
        callJS(action: body.action ,callbackId: body.callbackId,data: body.data ,code: body.code,msg: body.msg)
    }
    
    func handleWebCallApp(name:String,
                          params: Dictionary<String, Any>,
                          block: @escaping JSHandleModelCallBlock)  {
        
        PTDebugView.addLog("WebCallApp:" + "\(params.toQueryStr)")
        
        switch name {
        case "postMessage":
            if #available(iOS 13.0, *) {
                iOSBridgeCore.instance.handleCallApp(params: params.toJsonString ?? "", block: block)
            } else {
                // Fallback on earlier versions
            }
            break
        default:
            return
        }
    }
    
//    自定义事件,时长统计，子类实现
    open func event(eventId: String, msg: String) {
        
    }
    
    open func event(eventId: String, attributes: Dictionary<String, Any>) {
        
    }
    
    open func event(eventId: String, attributes: Dictionary<String, Any>, isAddDevice: Bool) {
        
    }
}

//MARK: JSbridge交互
public extension RSBridgeWebViewController {
    
    func addJShandleInterface(forKey key: String,bridgeObj: RSBridgeInterface) {
//        self.jsInterfaceMap[key] = bridgeObj
        iOSBridgeCore.instance.addJShandleInterface(forKey: key, bridgeObj: bridgeObj)
    }
    
    ///传入action对应的解析模型，使用类的类型，而非实例
    func addJShandleInterface<Model>(forKey key: String, 
                                     bridgeObj: RSBridgeProtocol,
                                     modelType: Model.Type) where Model: SmartCodable {
//        self.jsActionModelMap[key] = (bridgeObj, modelType)
        iOSBridgeCore.instance.addJShandleInterface(forKey: key, bridgeObj: bridgeObj, modelType: modelType)
    }
    
    func callJS(action: String , callbackId: Int = 0 ,data: [String : Any] = [:] , code : Int = 0 , msg : String = "") {
        if action == "" && callbackId == 0 {
            return
        }
        let dict :[String:Any] = ["action": action, "data":data, "callbackId":callbackId , "code" : code , "msg":msg];
        if let signedJSON = dict.toJsonString {
            let javeScriptStr = "try{JSBridge.callWeb(\(signedJSON))}catch(e){console.log(e)}"
            self.evaluateJavaScript(javeScriptStr)
        }
    }
    
    func addLog(_ body: RSBridgeModel)  {
        //自定义log
        body.dataFiltKeys = dataFiltKeys
        
#if DEBUG
        if !dataNoPrintKeysAndValue.isEmpty {
            let hasMatchingString = dataNoPrintKeysAndValue.contains(where: { str in
                body.description.contains(str)
            })
            if hasMatchingString {
                return
            }
        }
#endif
        PTDebugView.addLog("ios-call-web: \(body.description)")
        
    }
}

//MARK: 增加监听
extension RSBridgeWebViewController {
    
    public func registerObserver() {
        
        //        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
        //            .subscribe(onNext: { [weak self] _ in
        //                guard let `self` = self else {return}
        //                self.checkNetworkType(action:"networkChange",status:PTReachabilityManger.share.readReachabilityStatus())
        //                if self == homepageVc , homepageVc?.idlePolicy == 1 {
        //                    homepageVc?.osWakeTask = delay(time: TimeInterval(os_wake_time/1000), task: {
        //                        UIApplication.shared.isIdleTimerDisabled = false
        //                        homepageVc?.idlePolicy = 0
        //                    })
        //                }
        //            }).disposed(by: disposeBag)
        //
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
//                self.callJS(action: "appHide")
                appForEnterBackground = true
                self.callJS(body: CallWeb(action: "appHide"))
                //                self.puaseAllAudioPlayer()
                //                cancel(task: homepageVc?.osWakeTask)
            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else {return}
//                self.callJS(action: "appShow")
                appForEnterBackground = false
                self.callJS(body: CallWeb(action: "appShow"))
                
                //重新设置音频会话
                do {
                    try resetAudioSession()
                } catch  {
                    event(eventId: "Dmx_Client_Error", attributes: ["Dmx_Key_Data":"foregroundNotification\(error.localizedDescription)"])
                }
                
                //执行JS事件
                iOSBridgeCore.instance.executeJsEvents()
                //                self.resumeAllAudioPlayer()
                //                delay(time: 5,task:  {
                //                    PTIAPTool.share.resendReceipt()
                //                })
            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { _ in
//                self.callJS(action: "keyboardShow")
                self.callJS(body: CallWeb(action: "keyboardShow"))
            }).disposed(by: self.disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { _ in
//                self.callJS(action: "keyboardHide")
                self.callJS(body: CallWeb(action: "keyboardHide"))
            }).disposed(by: self.disposeBag)
    }
}

//MARK: JS监听回调
extension RSBridgeWebViewController: WKWebScriptMessageDelegate{
    
    public func zkUserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        guard let params : [String : Any]  = message.body as? [String : Any] else {return}
        
        handleWebCallApp(name: message.name, params: params) { body in
            //回调id
            let _ :[String:Any] = ["action": body.action,
                                   "data":body.data,
                                   "callbackId":body.callbackId ,
                                   "code" : body.code ,
                                   "msg":body.msg];
            do {
                //                if let signedJSON = dict.toJsonString {
                //                    replyHandler(signedJSON,nil);
                //                }
            }
            //iOS14后会，逐渐使用js和原生双向通信
            self.callJS(body: body)
        }
    }
    
    public func zkuserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let params : [String : Any]  = message.body as? [String : Any] else {return}
        handleWebCallApp(name: message.name, params: params) { body in
            self.callJS(body: body)
        }
    }
}

//MARK: WebView代理
extension RSBridgeWebViewController {
    
    open override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        self.callJS(action: "bridgeReady")
    }
    
}
