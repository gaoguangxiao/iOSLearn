//
//  Orbit.swift
//  004-SwiftUIRealityKit
//
//  Created by 高广校 on 2024/8/9.
//

import SwiftUI
import RealityKit

//struct Orbit: View {
//    
//    let earth: Entity
//    
//    var body: some View {
//        RealityView { content in
//            content.add(earth)
//        }
//
//    }
//}

struct Orbit: View {

    var body: some View {
        //从USD文件中加载实体
        RealityView { content in
            async let earth = ModelEntity(named: "Earth")
            if let earth = try? await earth {
                content.add(earth)
                //改变坐标
                earth.position = [0,0,0]
                
                //定义transform animation
                let orbit = OrbitAnimation(name: "Orbit",
                                           duration: 30,
                                           axis: [0, 1, 0],
                                           startTransform: earth.transform,
                                           bindTarget: .transform,
                                           repeatMode: .repeat)
//                 let orbit = OrbitAnimation(name: "orbit",
//                     duration: 10.0,
//                     axis: SIMD3<Float>(x: 0.0, y: 1.0, z: 0.0),
//                     startTransform: Transform(scale: simd_float3(10,10,10),
//                     rotation: simd_quatf(ix: 10, iy: 20, iz: 20, r: 100),
//                     translation: simd_float3(11, 2, 3)),
//                     spinClockwise: false,
//                     orientToPath: true,
//                     rotationCount: 100.0,
//                     bindTarget: nil)
                ///
                if let animation = try? AnimationResource.generate(with: orbit) {
                    earth.playAnimation(animation)
                }
            }
        }
    }
}

#Preview {
    Orbit()
}
