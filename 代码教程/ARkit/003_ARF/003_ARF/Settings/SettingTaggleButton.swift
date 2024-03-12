//
//  SettingTaggleButton.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct SettingTaggleButton: View {
    let setting: Setting
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        Button(action: {
            self.isOn.toggle()
            print("\(#file) - \(setting)：\(self.isOn)")
        }, label: {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(.plain)
                
                Text(setting.label)
                    .font(.system(size: 17,weight: .medium,design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top,5)
            }
        })
        .frame(width: 100,height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20)
    }
}

#Preview {
    SettingTaggleButton(setting: .pepleOcclusion, isOn: .constant(false))
}
