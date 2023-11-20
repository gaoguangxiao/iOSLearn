//
//  ToggleBoomcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct ToggleBoomcamp: View {
    @State var taggleIsOn: Bool = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Status:")
                Text(taggleIsOn ? "online":"offline")
            }
            
            Toggle(isOn:$taggleIsOn, label: {
                Text("打开状态")
            })
            .toggleStyle(SwitchToggleStyle(tint: .red))
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    ToggleBoomcamp()
}
