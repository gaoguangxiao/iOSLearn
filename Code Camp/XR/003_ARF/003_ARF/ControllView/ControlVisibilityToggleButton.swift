//
//  ControlVisibilityToggleButton.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct ControlVisibilityToggleButton: View {
    
    @Binding var isControlsVisiable: Bool
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button(action: {
                    self.isControlsVisiable.toggle()
                }, label: {
                    Image(systemName: self.isControlsVisiable ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(.plain)
                })
            }
            .frame(width: 50,height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
