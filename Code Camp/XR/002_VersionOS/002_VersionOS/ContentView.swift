//
//  ContentView.swift
//  002_VersionOS
//
//  Created by 高广校 on 2024/8/6.
//  哔哩哔哩 VersionOS-p8
//  1、场景加载进度
//  2、实现3D物体 绕自身旋转

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State var celestialObjects = [
    CelestialObject(name: "redchairScene", size: 200),
    CelestialObject(name: "teapotScene", size: 200),
    CelestialObject(name: "Scene", size: 100),
    ]
    var body: some View {
        TimelineView(.animation) { context in
            HStack {
                ForEach(celestialObjects, id: \.self) { object in
                    CelestialObjectView(name: object.name)
                        .rotation3DEffect(
                            //让围绕y轴旋转
                            Rotation3D(
                                angle: Angle2D(degrees: 5 * context.date.timeIntervalSinceReferenceDate),
                                axis: .y
                            )
                        )
                        .frame(depth: object.size, alignment: .front)
                        .frame(width: object.size)
                        .overlay {
                            Text(object.name)
                                .padding()
                                .glassBackgroundEffect()
                        }
                }
            }
        }
    }
}

struct CelestialObject: Equatable, Hashable {
    var name: String
    var size: CGFloat
}

//具体的模型
struct CelestialObjectView: View {
    var name: String
    var body: some View {
        Model3D(named: name,bundle: realityKitContentBundle) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let resolvedModel3D):
                resolvedModel3D
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                Text("失败了")
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
