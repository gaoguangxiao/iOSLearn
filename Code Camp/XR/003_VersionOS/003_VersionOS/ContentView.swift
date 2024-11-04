//
//  ContentView.swift
//  003_VersionOS
//
//  Created by 高广校 on 2024/8/6.
//

// SIMD3表示三维向量，包含三个标量值，可以是整数、浮点数或其他支持SIMD的操作系统
// 

import SwiftUI
import RealityKit
import RealityKitContent

struct PointOfInsterest: Hashable {
    
    var id: String = UUID().uuidString
    
    var name: String
    
    var location: SIMD3<Float>
}

struct ContentView: View {
    
    //? @GestureState属性修饰符怎么在手势中使用，查看README.md
//    @GestureState var manipulationState: GestureState<Vector3D>
    //
    @State var earthEntity: Entity = Entity()
    //我的收藏地点
    @State var favoritePlaces: [PointOfInsterest] = [
        PointOfInsterest(id: "1", name: "A", location: SIMD3(x: 0.01, y: -0.1, z: 0.04)),
        PointOfInsterest(id: "2", name: "B", location: SIMD3(x: -0.035, y: 0.095, z: 0.042)),
        PointOfInsterest(id: "3", name: "C", location: SIMD3(x: -0.07, y: -0.024, z: 0.079))
    ]
    
    var body: some View {
        //内容标记
        RealityView { content, attachments in
            do {
                earthEntity = try await Entity(named: "Scene", in: realityKitContentBundle)
                content.add(earthEntity)
            } catch {}
        } update: { content, attachments in
            //1.2、添加附着物
            for place in favoritePlaces {
                if let placeEntity = attachments.entity(for: place.id) {
                    content.add(placeEntity)
                    placeEntity.look(at: .zero, from: place.location, relativeTo: placeEntity.parent)
                }
            }
            
            //2.2、将`toy_biplane_idle`添加到视图中，并确定位置
            if let toyBiplaneIdleEntity = attachments.entity(for: "toy_biplane_idle") {
                content.add(toyBiplaneIdleEntity)
                toyBiplaneIdleEntity.position = SIMD3<Float>(x: 0, y: 0, z: 0.3)
//                toyBiplaneIdleEntity.setibl
            }
        } attachments: {
            //1.1、使用附着物
            ForEach(favoritePlaces,id: \.self) { place in
                Attachment(id: place.id) {
                    Text(place.name)
                        .glassBackgroundEffect()
                        .tag(place.id)
                }
            }
            //2.1 添加一个模型，并设置深度
            Attachment(id: "toy_biplane_idle") {
                Model3D(named: "toy_biplane_idleScene", bundle: realityKitContentBundle) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let resolvedModel3D):
                        resolvedModel3D
                            .resizable()
                            .scaledToFit()
                    case .failure(let error):
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(depth: nil, alignment: .center)
                .frame(width: 150)
//                .offset(x:manipulationState.transform.translation.x,
//                        y: manipulationState.transform.translation.y)
//                .gesture(manipulationGesture.updating($manipulationState, body: { value, state, _ in
//                    state.active = true
//                    state.tran
//                }))
                .tag("toy_biplane_idle")
            }
            
        }.gesture(SpatialTapGesture()
            .targetedToEntity(earthEntity)
            .onEnded({ value in
                let location = value.location3D
                //翻转坐标系：将' Point3D ' '从定义的SwiftUI坐标空间转换为RealityKit坐标空间中的3D点。
                let convertedLocation = 1.1 * value.convert(location, from: .local, to: .scene)
                print("convertedLocation: \(convertedLocation)")
                favoritePlaces.append(PointOfInsterest(name: "New", location: convertedLocation))
            })
        )
    }
    
    //拖动手势转换3D
    var manipulationGesture: some Gesture<AffineTransform3D> {
        DragGesture()
            .map { gesture in
                let translation = gesture.translation3D
                return AffineTransform3D(translation: translation)
            }
    }
    
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
