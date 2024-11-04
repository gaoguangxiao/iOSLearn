//
//  ContentView.swift
//  002_RealityKIt
//
//  Created by 高广校 on 2024/2/19.
//  工程要贴学习截图


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
        //print("tapLocation:\(tapLocation)")
        
        //确定通过给定点的射线的位置和方向
        guard let rayResult = self.ray(through: tapLocation) else {
            print("guard nil `self.ray(through: tapLocation`")
            return
        }
//        print("射线:\(rayResult)")
//    射线:(origin: SIMD3<Float>(-0.12929419, 0.11039211, 0.082384184), direction: SIMD3<Float>(0.1813044, -0.6487257, -0.7391102))
        //       print("self.scene:\(self.scene)")
        
        
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        print("光线投射方向:\(results)")
        
        if let firstResult = results.first {
            //模型的堆叠
            
        } else {
            //执行光线投射，其中光线从中心投射到场景中
//            - point:视图的本地坐标系统中的一个点。 屏幕点击点
//            - target:射线终止的目标类型。设置为平面
//            - align:目标对齐。any
    
//            从相机。如果光线投射失败，列表为空。
            let raycastResults = self.raycast(from: tapLocation,
                                       allowing: .estimatedPlane,
                                       alignment: .any)
            //
//            print("投射结果:\(raycastResults)")
//        投射结果:[<ARRaycastResult: 0x300228d10 target=estimatedPlane worldTransform=<translation=(0.067537 -0.605372 -0.731807) rotation=(-0.00° -13.58° 0.00°)>>]
            
            if let firstResult = raycastResults.first {
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
//        mesh = MeshResource.generateSphere(radius: 0.01)
        //
        
        //SimpleMaterial：表示渲染网格的基本材质
//        roughness: 材料的粗糙度
        let material = SimpleMaterial(color: UIColor.randomColor(),
                                      roughness: 0.3,
                                      isMetallic: true)
        
        //ModelEntity：表示呈现和可选模拟的模型
        let modelEntity = ModelEntity(mesh: mesh, 
                                      materials: [material])
        //创建用于检测两个实体之间碰撞的形状
        modelEntity.generateCollisionShapes(recursive: true)
        
//        AnchorEntity: 表示可以在AR场景中锚定的实体
//        - position:初始化世界目标的位置。
        let anchorEntity = AnchorEntity(world: position)
        //将给定实体添加到子实体集合中。
        anchorEntity.addChild(modelEntity)
        //向场景的锚列表中添加一个锚。
        self.scene.addAnchor(anchorEntity)
        
    }
}

#Preview {
    ContentView()
}
