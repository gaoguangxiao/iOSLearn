//
//  SwiftUIGlobeView.swift
//  MyFirstWindow-None
//
//  Created by 高广校 on 2024/8/7.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SwiftUIGlobeView: View {
    //定义旋转角度
    @State var rotation = Angle.zero
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            Model3D(named: "Earth",
                    bundle: realityKitContentBundle)
            .rotation3DEffect(rotation, axis: .y)
            .onTapGesture {
                withAnimation(.bouncy) {
                    rotation.degrees = randomRotation()
                }
            }
            .padding3D(.front,150) //3D修改器
            
            Text("文本视图")
                .glassBackgroundEffect(in: .capsule)
        }
        
    }
    
    func randomRotation() -> Double {
        Double.random(in: 360...720)
    }
}

#Preview {
    SwiftUIGlobeView()
}
