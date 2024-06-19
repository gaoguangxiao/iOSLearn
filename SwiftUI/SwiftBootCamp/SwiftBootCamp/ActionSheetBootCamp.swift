//
//  ActionSheetBootCamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2024/6/14.
//

import SwiftUI

struct ActionSheetBootCamp: View {
    
    @State private var isAlertShowing = false
    
    @State var engineType: Int = 0
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("引擎类别"),
                    message: Text("请选择一个引擎，默认腾讯语音识别"),
                    buttons: [
                        .default(Text("腾讯语音识别"), action: {
                            engineType = 0
                        }),
                        .default(Text("Apple语言识别"), action: {
                            engineType = 1
                        }),
                        .destructive(Text("取消"), action: {
                            
                        })
                    ]
        )
    }    
    
    var body: some View {
        
        Button("识别引擎:\(engineType == 0 ? "腾讯语音识别": "Apple语言识别")") {
            self.isAlertShowing = true
        }.actionSheet(isPresented: $isAlertShowing, content: {
            self.actionSheet
        })
    }
}

#Preview {
    ActionSheetBootCamp()
}
