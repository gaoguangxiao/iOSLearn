//
//  GXMessageBridge.swift
//  SwiftUiCreate
//
//  Created by 高广校 on 2023/11/22.
//

import Foundation
import WebKit

class GXMessageBridge: NSObject,WKScriptMessageHandler , WKScriptMessageHandlerWithReply{
    weak var scriptDelegate: WKScriptMessageHandler?
    
    weak var scriptWithReplyDelegate: WKScriptMessageHandlerWithReply?
    
    init(_ scriptDelegate: WKScriptMessageHandler) {
        super.init()
        self.scriptDelegate = scriptDelegate
    }
    
    init(scriptWithReplyDelegate: WKScriptMessageHandlerWithReply) {
        super.init()
        self.scriptWithReplyDelegate = scriptWithReplyDelegate
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        scriptDelegate?.userContentController(userContentController, didReceive: message)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        if #available(iOS 14.0, *) {
            scriptWithReplyDelegate?.userContentController(userContentController, didReceive: message, replyHandler: replyHandler)
        } else {
            // Fallback on earlier versions
            
        }
    }
}
