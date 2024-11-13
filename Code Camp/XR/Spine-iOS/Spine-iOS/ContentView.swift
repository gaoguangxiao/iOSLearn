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
    
    @State
    var isFaceRight = false
    
    var body: some View {
        
        VStack {
            if let spineView = skeletonScript.spineView {
                spineView
                    .frame(height: 200)
                    .background(Color.gray)
            }
            
            if let datas = source.datas {
                ItemCharacterView(skeletonScript: skeletonScript, datas: datas)
                // background(Color.red)
            }
            
            Divider()
            //动作列表、皮肤列表
            HStack {
                ButtonView(action: {
                    isLoop.toggle()
                }, title: "动作列表")
                
                ButtonView(action: {
                    isLoop.toggle()
                }, title: "皮肤列表")
            }
            Divider()
            //控制速度、反向、循环
            HStack {
                ButtonView(action: {
                    isLoop.toggle()
                }, title: "循环\(isLoop ? "开启" : "关闭")")
                
                ButtonView(action: {
                    isReverse.toggle()
                }, title: "反向\(isReverse ? "开启" : "关闭")")
                
                ButtonView(action: {
                    isMultiplierSpeed.toggle()
                }, title: "倍速\(isMultiplierSpeed ? "开启" : "关闭")")
                ButtonView(action: {
                    isFaceRight.toggle()
                    skeletonScript.scaleX(faceLeft: isFaceRight ? -1 : 1)
                }, title: "默认\(isFaceRight ? "开启" : "关闭")")
                
            }
            Divider()
            //                Spacer()
            //渲染datum动作
            if let animations = skeletonScript.skeletonData?.animations {
                HStack {
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
                    }
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

struct ButtonView: View {
    
    var action: (() -> Void)
    
    var title: String
    
    var body: some View {
        Button { action() }
        label: { Text(title)
                .frame(height: 30)
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(.capsule)
        }
    }
}

struct ItemCharacterView: View {
    let rows: [GridItem] = [
        GridItem(.fixed(40)),
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
            //            LazyHGrid(rows: <#T##[GridItem]#>, content: <#T##() -> Content#>)
            LazyHGrid(rows: rows, spacing: 8) {
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
