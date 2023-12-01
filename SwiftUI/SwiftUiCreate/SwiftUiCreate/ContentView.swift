//
//  ContentView.swift
//  SwiftUiCreate
//
//  Created by 高广校 on 2023/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var webUrl: String? = "http://qa.risekid.cn"
    
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
    
    var body: some View {
        
        ZStack(content: {
            Color
                .red
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            //业务控制器
            GXWKWebView(url: $webUrl)
                .addScriptMessage(name: "postMessage")
                .setUA(customUserAgent: RSUtils.deviceIdentifier)
                .addUserScript(forSource: jsCode)
                .onReceive(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Publisher@*/NotificationCenter.default.publisher(for: .NSCalendarDayChanged)/*@END_MENU_TOKEN@*/, perform: { _ in
                    
                })
        })

    }
}

#Preview {
    ContentView()
}
