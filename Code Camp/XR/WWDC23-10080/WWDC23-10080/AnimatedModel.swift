//
//  AnimatedModel.swift
//  004-SwiftUIRealityKit
//
//  Created by 高广校 on 2024/8/9.
//  加载usdz文件之后 播放动画

import SwiftUI
import RealityKit

struct AnimatedModel: View {
    
    //订阅者
    @State var subscription: EventSubscription?
    
    var body: some View {
        RealityView { content in
            if let moon = try? await Entity(named: "Earth"),
               let animation = moon.availableAnimations.first {
                moon.playAnimation(animation)
                content.add(moon)
                
            }
            subscription = content.subscribe(to: AnimationEvents.PlaybackCompleted.self) {_ in
                // 动画完毕之后 运行一段代码
            }
        }
    }
}

#Preview {
    AnimatedModel()
}
