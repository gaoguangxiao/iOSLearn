//
//  ContentView.swift
//  002_RealityKIt
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI
import RealityKit

extension UIColor {
    class func randomColor() -> UIColor {
        let colors: [UIColor] = [.white,.red,.blue,.yellow,.orange,.green]
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        
        return colors[randomIndex]
    }
}

struct ContentView : View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero,cameraMode: .ar,automaticallyConfigureSession: true)
        
        // 开启手势点击
        arView.enableTapGesture()

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
}

extension ARView {
    
    //实现点击事件
    func enableTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        //获取Tap的位置
        let tapLocation = recognizer.location(in: self)
        //       print("tapLocation:\(tapLocation)")
        
        //确保有触碰的物体
        guard let rayResult = self.ray(through: tapLocation) else { return }
        
        //       print("self.scene:\(self.scene)")
        
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        
        //       print("results:\(results)")
        
        if let firstResult = results.first {
            //模型的堆叠
            
        } else {
            let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
            
//            print("results:\(results)")
            
            if let firstResult = results.first {
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                
                placeCube(at: position)
            }
        }
    }
    
    //实现模型的添加
    func placeCube(at position: SIMD3<Float>) {
        
        print("position:\(position.y)")
        
//        MeshResource：表示渲染的网格资源
        
        // 正方体
        var mesh = MeshResource.generateBox(size: 0.1,cornerRadius: 0.01)
        // 球形
        mesh = MeshResource.generateSphere(radius: 0.01)
        
        
        //SimpleMaterial：表示渲染网格的基本材质
        let material = SimpleMaterial(color: UIColor.randomColor(),
                                      roughness: 0.3,
                                      isMetallic: true)
        
        //ModelEntity：表示呈现和可选模拟的模型
        let modelEntity = ModelEntity(mesh: mesh, 
                                      materials: [material])
        
        modelEntity.generateCollisionShapes(recursive: true)
        
//        AnchorEntity 表示可以在AR场景中锚定的实体
        let anchorEntity = AnchorEntity(world: position)
        
        anchorEntity.addChild(modelEntity)
        
        self.scene.addAnchor(anchorEntity)
        
    }
}

#Preview {
    ContentView()
}
