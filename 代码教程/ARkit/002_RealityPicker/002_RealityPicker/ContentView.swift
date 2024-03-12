//
//  ContentView.swift
//  002_RealityPicker
//
//  Created by 高广校 on 2024/2/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    var models = ["biplane",
                  "robot_walk_idle",
                  "teapot",
                  "drummertoy",
                  "retrotv"]
    
    var body: some View {
        //        ZStack {
        
        //            ARViewContainer().edgesIgnoringSafeArea(.all)
        
        Spacer()
        
        ModelsView(models: models)
        
        //        }
        
    }
}

struct ModelsView: View {
    
    var models: [String]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack(spacing: 30, content: {
                
                ForEach(models, id: \.self) { model in
                    
                    Button(action: {
                        
                        print("点击")
                        
                    }, label: {
                        Image(model, bundle: .main)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fill)
                            .background(Color.white)
                            .cornerRadius(12)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            })
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
        
    }
    
    
    
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.05
        
        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model)
        
        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
