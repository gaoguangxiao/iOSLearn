//
//  SkeletonUIView.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import SwiftUI
import Spine

struct SkeletonUIView: View {
    
    @StateObject
    var skeletonGraphic = SkeletonGraphicScript();
    
    var datum: Datum?
    
    @State
    var isRendering: Bool?
    
    var body: some View {
       
        VStack {
            Text("From-Bundle")

            if let drawable = skeletonGraphic.drawable {
                SpineView(from: .drawable(drawable),
                          isRendering: $isRendering)
                    .frame(height: 100)
            } else {
                Text("load error drawable")
            }
        }
        .task {
            if let atlas = datum?.atlas ,let json = datum?.json {
                Task.detached {
                    do {
                        try await skeletonGraphic.updateAsset(atlasFileName: atlas, jsonPathName: json)
//                        await skeletonGraphic.drawable?.skeleton.setSkinByName(skinName: "moren")
//                        await skeletonGraphic.drawable?.skeleton.setToSetupPose()
                    } catch  {
                        
                    }
                }
            }
        }
        .onAppear {
//            isRendering = true
            
        }
        .onDisappear {
//            isRendering = false
        }
    }
}

#Preview {
    SkeletonUIView()
}
