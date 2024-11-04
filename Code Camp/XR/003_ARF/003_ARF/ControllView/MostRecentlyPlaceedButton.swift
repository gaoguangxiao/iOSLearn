//
//  MostRecentlyPlaceedButton.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct MostRecentlyPlaceedButton: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        
        Button(action: {
            print("Most Recently Placed button pressed")
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }, label: {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46)
                    .aspectRatio(1/1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(.plain)
            }
        })
        .frame(width: 50,height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
    }
}
