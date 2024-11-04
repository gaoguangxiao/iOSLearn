//
//  RotatedModel.swift
//  004-SwiftUIRealityKit
//
//  Created by 高广校 on 2024/8/9.
//  模型旋转

import SwiftUI
import RealityKit

//Angle2D
//返回一个角度
//public init(degrees: Double)

//RotationAxis3D【一个3D轴。】
//从指定的值返回旋转轴。
//@inlinable public init(x: Double = 0, y: Double = 0, z: Double = 0)

//Rotation3D
//以指定的角度在指定的轴上旋转。
//public init(angle: Angle2D, axis: RotationAxis3D)

struct RotatedModel: View {
    
    @State var earthEntity: Entity = Entity()
    
    //旋转
    var rotation: Rotation3D = Rotation3D(angle: Angle2D(degrees: 80),
                                          axis: .init(x: 0, y: 0, z: 0))
    
    var body: some View {
        RealityView { content in
            async let earth = ModelEntity(named: "Earth")
            if let earth = try? await earth {
                earthEntity = earth
                content.add(earth)
                //改变坐标
                earth.position = [0,0,0]
            }
        } update: { content in
            earthEntity.orientation = .init(rotation)
        }
    }
}

#Preview {
    RotatedModel()
}
