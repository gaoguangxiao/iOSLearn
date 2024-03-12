//
//  PlacementView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/23.
//

import SwiftUI

struct PlacementView:View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        HStack {
         
            Spacer()
            
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("Cancel Placement button pressed.")
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
            
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("Confirm Placement button pressed.")
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
            
        }
    }
}

struct PlacementButton: View {
    
    let systemIconName: String
    
    let action: ()-> Void
    
    var body: some View {
        
        Button {
            self.action()
        } label: {
            Image(systemName: systemIconName)
                .font(.system(size: 50,weight: .light,design: .default))
                .foregroundColor(.white)
                .buttonStyle(.plain)
        }
        .frame(width: 75,height: 75)

    }
}
