//
//  ImmersiveView.swift
//  MyFirstVolume-None
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        
        RealityView { content in
          // Add the initial RealityKit content
          if let scene = try? await Entity(named: "ImmersiveScene", in: realityKitContentBundle) {
              content.add(scene)
          }
      }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
