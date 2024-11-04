//
//  ContentView.swift
//  002_RealityPicker
//
//  Created by 高广校 on 2024/2/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @State var modelString: String?
    
    var models = ["biplane",
                  "robot_walk_idle",
                  "teapot",
                  "drummertoy",
                  "retrotv"]
    
    var body: some View {
        ZStack {
            
            ARViewContainer(modelString: $modelString)
                .edgesIgnoringSafeArea(.all)
            
            ModelsView(models: models) { str in
                modelString = str
            }
        }
        
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelString: String?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .red, roughness: 0.15, isMetallic: true)
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.05
        
        // 为内容创建一个水平平面
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model)
        
        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        guard let modelString  else { return }
        //设置选中的模型体
        guard let modelEntity = try? ModelEntity.loadModel(named: modelString) else {
        print("guard nil ModelEntity.loadModel(named: \(modelString)")
            return
        }
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(modelEntity)
        uiView.scene.anchors.append(anchorEntity)
    }

}

#Preview {
    ContentView()
}
