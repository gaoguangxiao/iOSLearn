//
//  ControlView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/22.
//

import SwiftUI

struct ControlView: View {
    
    @Binding var isControlsVisiable: Bool
    
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
     
    var body: some View {
        
        VStack {
            
            ControlVisibilityToggleButton(isControlsVisiable: $isControlsVisiable)
            
            Spacer()
            
            if isControlsVisiable {
                ControlButtonBar(showBrowse: $showBrowse,showSettings: $showSettings)
            }
            
        }

    }
}

#Preview() {
    ControlView(isControlsVisiable: .constant(true),showBrowse: .constant(false), showSettings: .constant(false))
}
