//
//  RealityLearnView.swift
//  MyFirstWindow-None
//
//  Created by 高广校 on 2024/8/7.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct GlobeLocation {
    
    var location: Point3D
}

struct RealityLearnView: View {
    
    @State var rotation = Angle.zero
    
    //RealityView上添加手势
    @State private var pinLocation: GlobeLocation?
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let earth = try? await
                Entity(named: "Scene",in: realityKitContentBundle)
                {
                   content.add(earth)
                }
        }.onTapGesture {
            withAnimation(.bouncy) {
                rotation.degrees = randomRotation()
            }
        }
//        .gesture(SpatialTapGesture()
//                .targetedToAnyEntity()
//                .onEnded { value in
//                    print("点击")
//                    pinLocation = lookUpLocation(at: value.gestureValue)
//                }
//        )
    
    }
    
    func randomRotation() -> Double {
        Double.random(in: 360...720)
    }
    
    func lookUpLocation(at value: SpatialTapGesture.Value) -> GlobeLocation {
    
        let location = value.location3D
        
        return GlobeLocation(location: location)
    }
}

#Preview {
    RealityLearnView()
}
