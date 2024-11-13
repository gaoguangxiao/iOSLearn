//
//  ContentView.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import SwiftUI
import Spine
import GGXSwiftExtension

struct ContentView: View {
    
    @StateObject
    var skeletonScript = SkeletonGraphicScript()
    
    @StateObject
    var source = SkeletonSource()
    
    var body: some View {
        
        HStack {
            SpineView(from: .bundle(atlasFileName: "spineboy-pma.atlas", skeletonFileName: "spineboy-pro.skel"))
            
            if let drawable = skeletonScript.drawable {
                SpineView(from: .drawable(drawable),
                          controller: skeletonScript.controller,
                          isRendering: $skeletonScript.isRendering)
            }
                        
            VStack {
                if let datas = source.datas {
                    List {
                        ForEach(datas) { datum in
                            if let name = datum.name {
                                Button {
                                    Task.detached {
                                        try await skeletonScript.updateAssetFromBundle(datum: datum)
                                    }
                                } label: {
                                    Text(name)
                                }
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                Button {
                    source.loadCharaterJSON()
                } label: {
                    Text("刷新")
                }
            }
        }
        .onAppear {
            source.loadCharaterJSON()
        }
    }
}

#Preview {
    ContentView()
}

