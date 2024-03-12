//
//  OpenContentView.swift
//  MyFirstVolume-None
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct OpenContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    
    var body: some View {
        
        Button("Open") {
            Task {
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
        }
    }
}

#Preview {
    OpenContentView()
}
