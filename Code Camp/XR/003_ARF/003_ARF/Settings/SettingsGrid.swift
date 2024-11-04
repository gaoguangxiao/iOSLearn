//
//  SettingsGrid.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct SettingsGrid: View {
    
    @EnvironmentObject var sessionSettings: SessionSettings
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100),spacing: 25)]
    
    var body: some View {
        
        ScrollView {
  
            LazyVGrid(columns: gridItemLayout, spacing: 25) {
                
                SettingTaggleButton(setting: .pepleOcclusion, isOn: $sessionSettings.isPeopleOcclusionEnable)
                
                SettingTaggleButton(setting: .objectOcclusion, isOn: $sessionSettings.isObjectOcclusionEnable)
                
                SettingTaggleButton(setting: .lidarDebug, isOn: $sessionSettings.isLidarDebugEnable)
                
                SettingTaggleButton(setting: .multiuser, isOn: $sessionSettings.isMultiuserEnable)
            }
        }
        .padding(.top, 35)
    }
}

#Preview {
    SettingsGrid()
        .environmentObject(SessionSettings())
}
