//
//  RecentsGrid.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct RecentsGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @Binding var showBrowse: Bool
    
    var body: some View {
    
        if !self.placementSettings.recentlyPlaced.isEmpty {
            HorizontalGrid(showBrowse: $showBrowse, title: "Recents", items: getRecentsUniqueOrdered())
        }
    }
    
    func getRecentsUniqueOrdered() -> [Model] {
        
        var recentsUniqueOrderedArray: [Model] = []
        var modelsNameSet: Set<String> = []

        for model in self.placementSettings.recentlyPlaced.reversed() {
            if !modelsNameSet.contains(model.name) {
                recentsUniqueOrderedArray.append(model)
                modelsNameSet.insert(model.name)
            }
        }
        
        return recentsUniqueOrderedArray
    }
}

#Preview {
    RecentsGrid(showBrowse: .constant(true))
}
