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
  
            if let spineView = skeletonScript.spineView {
                spineView
            }
            
            VStack {
                if let datas = source.datas {
                    List {
                        ForEach(datas) { datum in
                            if let name = datum.name {
                                Button {
                                    Task.detached {
                                        do {
                                            try await skeletonScript.setSkeletonFromFile(datum: datum)
                                        } catch {
                                            print("error: \(error)")
                                        }
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

