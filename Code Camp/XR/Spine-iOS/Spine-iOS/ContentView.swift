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
    
    // 定义网格行，设置每行的高度
    let rows: [GridItem] = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    
    @State
    var isLoop = false
    
    @State
    var isReverse = false
    
    @State
    var isMultiplierSpeed = false
    
    var body: some View {
        
        HStack {
            HStack {
                if let spineView = skeletonScript.spineView {
                    spineView
                        
                }
            }
            .frame(width: 300)
//            Spacer()
            VStack {
                if let datas = source.datas {
                    ItemCharacterView(skeletonScript: skeletonScript, datas: datas)
                }
                
                //控制速度、反向、循环
                HStack {
                    Button {
                        isLoop.toggle()
                    } label: {
                        Text("循环：\(isLoop ? "开启" : "关闭")")
                    }
                    
                    Button {
                        isReverse.toggle()
                    } label: {
                        Text("反向：\(isReverse ? "开启" : "关闭")")
                    }
                    
                    Button {
                        isMultiplierSpeed.toggle()
                    } label: {
                        Text("2倍速：\(isMultiplierSpeed ? "开启" : "关闭")")
                    }
                }
                
                Spacer()
                //渲染datum动作
                if let animations = skeletonScript.skeletonData?.animations {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, spacing: 10) {
                            ForEach(animations, id: \.self) { animation in
                                if let name = animation.name {
                                    Button {
                                        skeletonScript.playAnimationName(animationName: name,loop: isLoop,reverse: isReverse,timeScale: isMultiplierSpeed ? 2.0: 1.0)
                                    } label: {
                                        Text(name)
                                            .frame(width: 100, height: 30, alignment: .center)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(.capsule)
                                    }
                                }
                               
                            }
                        }
//                        .padding()
                    }
                }
                
                
                Button {
                    source.refresh()
                } label: {
                    Text("刷新")
                }
            }
            
        }
        .task {
            await source.loadCharaterJSON()
            //加载一个
            if let datas = source.datas,
               let datum = datas.first {
                try? await skeletonScript.setSkeletonFromFile(datum: datum)
            }
        }
        .onAppear {
            //            source.loadCharaterJSON()
        }
    }
}

#Preview {
    ContentView()
}

struct ItemCharacterView: View {
    let rows: [GridItem] = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    
    @ObservedObject
    var skeletonScript: SkeletonGraphicScript
    
    var datas: [Datum]
    
    var body: some View {
       
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 10) {
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
                                .frame(width: 100, height: 30, alignment: .center)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(.capsule)
                        }
                       
                    }
                }
            }
//                        .padding()
        }
    }
}
