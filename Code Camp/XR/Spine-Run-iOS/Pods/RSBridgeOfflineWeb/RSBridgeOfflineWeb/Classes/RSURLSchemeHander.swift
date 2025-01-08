//
//  RSURLSchemeHander.swift
//  RSReading
//
//  Created by 高广校 on 2023/11/8.
//

import Foundation
import WebKit
import GGXOfflineWebCache
import GGXSwiftExtension

public class RSURLSchemeHander: GXURLSchemeHander {
    
}

//@available(iOS 11.0, *)
extension RSURLSchemeHander {
    
    public override func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        //1、URL
        guard let url = urlSchemeTask.request.url else {
            return
        }
        
//        PTDebugView.addLog("拦截的URL:\(url.absoluteString)")
        if let data = RSWebOfflineManager.share.requestOfflineDataWith(url: url.absoluteString){
            let MIMEType = url.absoluteString.getMIMETypeFromPathExtension()
            if let response = HTTPURLResponse(url: url, statusCode: 200,
                                              httpVersion: "http:1.1", headerFields: ["Content-Type":MIMEType,"Access-Control-Allow-Origin":"*"]) {
                urlSchemeTask.didReceive(response)
                urlSchemeTask.didReceive(data)
                urlSchemeTask.didFinish()
            }
            
        } else {
//            PTDebugView.addLog("网络策略：\(url)")
            super.webView(webView, start: urlSchemeTask)
        }

    }
    
    public override func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        super.webView(webView, stop: urlSchemeTask)
    }
    
}
