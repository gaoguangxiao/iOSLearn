//
//  ContentView.swift
//  MyFirstVolume-None
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    
    var body: some View {
        VStack {
//            RealityView 允许您将显示内容放置到UI视图层次结构中
            
              RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(
                TapGesture()
                    .targetedToAnyEntity()
                    .onEnded { _ in
                enlarge.toggle()
            })

            VStack {
                Toggle("Change Size", isOn: $enlarge)
                    .toggleStyle(.button)
            }
            .padding()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
