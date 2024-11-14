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
    var isAnimationView = false
    
    var body: some View {
        
        VStack {
            if let spineView = skeletonScript.spineView {
                spineView
                    .frame(height: 300)
                    .background(Color.gray)
                    .padding()
            }
            
            if let datas = source.datas {
                ItemCharacterView(skeletonScript: skeletonScript, datas: datas)
            }
            
            Divider()
            //动作列表、皮肤列表
            HStack {
                ButtonView(action: {
                    isAnimationView.toggle()
                }, title: "动作列表")
                
                ButtonView(action: {
                    isAnimationView.toggle()
                }, title: "皮肤列表")
            }
            Divider()
            
            if isAnimationView {
                ControllView(skeletonScript: skeletonScript)
            } else {
                SKinListView(skeletonScript: skeletonScript)
            }
            
            Spacer()

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

//MARK: 皮肤控制
struct SKinListView: View {
    
    @ObservedObject
    var skeletonScript: SkeletonGraphicScript
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        if let skins = skeletonScript.skeletonData?.skins {
            HStack {
                ScrollView(.vertical) {
//                            LazyVGrid(columns: columns, content: <#T##() -> Content#>)
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(skins, id: \.self) { skin in
                            if let name = skin.name {
                                Button {
                                    skeletonScript.initCharaterSkin(name)
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
}


//MARK: - 动作控制
class AnimationConrollModel: ObservableObject {
    
    @Published
    var isLoop = false
    
    @Published
    var isReverse = false
    
    @Published
    var isMultiplierSpeed = false
    
    @Published
    var isFaceRight = false
}

struct ControllView: View {
    
    @StateObject
    var conrollModel = AnimationConrollModel()
    
//    @ObservedObject
//    var conrollModel: AnimationConrollModel
    
    @ObservedObject
    var skeletonScript: SkeletonGraphicScript
    
    let rows: [GridItem] = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    
    var body: some View {
        //控制速度、反向、循环
        HStack {
            ButtonView(action: {
                conrollModel.isLoop.toggle()
            }, title: "循环\(conrollModel.isLoop ? "开启" : "关闭")")
            
            ButtonView(action: {
                conrollModel.isReverse.toggle()
            }, title: "反向\(conrollModel.isReverse ? "开启" : "关闭")")
            
            ButtonView(action: {
                conrollModel.isMultiplierSpeed.toggle()
            }, title: "倍速\(conrollModel.isMultiplierSpeed ? "开启" : "关闭")")
            ButtonView(action: {
                conrollModel.isFaceRight.toggle()
                skeletonScript.scaleX(faceLeft: conrollModel.isFaceRight ? -1 : 1)
            }, title: "默认\(conrollModel.isFaceRight ? "开启" : "关闭")")
        }
        
        Divider()
        
        //渲染datum动作
        if let animations = skeletonScript.skeletonData?.animations {
            HStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(animations, id: \.self) { animation in
                            if let name = animation.name {
                                Button {
                                    skeletonScript.playAnimationName(animationName: name,
                                                                     loop: conrollModel.isLoop,
                                                                     reverse: conrollModel.isReverse,
                                                                     timeScale: conrollModel.isMultiplierSpeed ? 2.0: 1.0)
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

//MARK: - 角色
struct ItemCharacterView: View {
    let rows: [GridItem] = [
        GridItem(.fixed(31)),
        GridItem(.fixed(31)),
//        GridItem(.fixed(40)),
        GridItem(.fixed(31)),
        GridItem(.fixed(31))
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
        }
    }
}
