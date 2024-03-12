//
//  ContentView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @State var isControlsVisiable: Bool = true
    @State var showBrowse: Bool = false
    @State var showSettings: Bool = false
    
    var body: some View {

        ZStack(alignment: .bottom) {
            
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            if self.placementSettings.selectedModel == nil {
                ControlView(isControlsVisiable: $isControlsVisiable, showBrowse: $showBrowse,showSettings: $showSettings)
//                    .background(Color.yellow)
            } else {
                PlacementView()
            }
        }
//        .edgesIgnoringSafeArea(.all)
//        .background(Color.red)
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var sessionSettings: SessionSettings
    
    func makeUIView(context: Context) -> CustomARView {
        
        let arView = CustomARView(frame: .zero,sessionSettings: sessionSettings)

        // Subscribe to SceneEvents.Update
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
            
            //TODO: call updateScene method
            self.updateScene(for: arView)
        })
        
        return arView
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    func updateScene(for arView: CustomARView) {
        
        //only display focusentity when the user has selected a model for placement
        arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        //add a model to scene if confirmed for placement
        if let confirmedModel = placementSettings.confirmedModel, 
            let modelEntity = confirmedModel.modelEntity {
            
            self.place(modelEntity, in: arView)
            
            self.placementSettings.confirmedModel = nil
        }
    }
    
    func place(_ modelEntity: ModelEntity, in arView: ARView) {
        //1、Clone modelentity.
        let clonedEntity = modelEntity.clone(recursive: true)
        
        //
        clonedEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.translation,.rotation], for: clonedEntity)
        
        //3、 create an anchorEntity and add cloneENtity to the anchorEntity
        let anchorEntity = AnchorEntity(plane: .any)
//        AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        //4、add the anchorEntity to the arview.scene
        arView.scene.addAnchor(anchorEntity)
    }
}

#Preview {
    ContentView()
        .environmentObject(PlacementSettings())
        .environmentObject(SessionSettings())
}
