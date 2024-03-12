//
//  ControlButtonBar.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

///
struct ControlButtonBar: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {

        HStack {
            
            // MostRecentlyPlaced Button
            MostRecentlyPlaceedButton().hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            
            // Browse button 
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed")
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse, content: {
                BrowseView(showBrowse: $showBrowse)
            })
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Settings button pressed")
                self.showSettings.toggle()
            }.sheet(isPresented: $showSettings, content: {
                SettingsView(showSettings: $showSettings)
            })
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}
