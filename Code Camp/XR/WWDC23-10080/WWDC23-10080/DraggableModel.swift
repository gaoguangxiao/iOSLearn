//
//  DraggableModel.swift
//  004-SwiftUIRealityKit
//
//  Created by 高广校 on 2024/8/9.
//  Reality中的手势，需要将usdz文件放置场景中，并给该对象赋予可输入以及碰撞功能。使用Realty Comp pro打开，创建场景

import SwiftUI
import RealityKit
import RealityKitContent

struct DraggableModel: View {
    
    @State var earth: Entity = Entity()
    
    var body: some View {
        
        RealityView { content in
            do {
                earth = try await Entity(named: "DraggableScene", in: realityKitContentBundle)
                content.add(earth)
            } catch {}
            
        }
        .gesture(DragGesture()
            .targetedToEntity(earth)
            .onChanged({ value in
                earth.position = value.convert(value.location3D,
                                               from: .local,
                                               to: earth.parent!)
                print("drag position：\(earth.position)")
            })
        )
        
        
    }
}

#Preview {
    DraggableModel()
}
