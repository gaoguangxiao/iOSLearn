//
//  SkeletonUIView.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import SwiftUI
import Spine

enum AssetFileSourceType {
    case bundle
    case file
    case http
}

struct SkeletonUIView: View {
    
    @StateObject
    var skeletonGraphic = SkeletonGraphicScript();
    
    var datum: Datum?
    
    var sourceType: AssetFileSourceType = .bundle
    
    @State
    var isRendering: Bool?
    
    var body: some View {
       
        VStack {
            Text(sourceType == .bundle ? "From-Bundle" : "Form-file")
            if let spineView = skeletonGraphic.spineView {
                spineView
                    .frame(height: 100)
            } else {
                Text("load error drawable")
            }
        }
        .task {
            if let datum {
                if sourceType == .bundle {
                    try? await skeletonGraphic.setSkeletonFromBundle(datum: datum)
                } else {
                    try? await skeletonGraphic.setSkeletonFromFile(datum: datum)
                }
            }
        }
        .onAppear {
            isRendering = true
            
        }
        .onDisappear {
            isRendering = false
        }
    }
}

#Preview {
    SkeletonUIView()
}
