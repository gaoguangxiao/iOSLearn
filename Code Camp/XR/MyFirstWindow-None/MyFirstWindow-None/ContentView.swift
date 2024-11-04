//
//  ContentView.swift
//  MyFirstWindow-None
//
//  Created by 高广校 on 2024/2/19.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    //存储与当前正在进行的手势关联的值，例如您滑动了多远，除非在手势停止时它将重置为其默认值。
    //使用`@GestureState`属性包装器定义一个拖曳参数`myState`，用来记录我们的拖曳前的初始位置，也用来监听和更新UI //    @GestureState private var myState = CGSize.zero
    @GestureState var offset: SIMD3<Float> = [0, 0, 0]
    
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
                .gesture(
                    //拖
                    DragGesture()
                        .targetedToAnyEntity()
                        .updating($offset, body: { value, state, gameo in
                            //                        value: 当前位置
//                            print("value:\(value.translation3D)")
//                            print(gameo)
                            
//                             state = [Float(value.translation.width), -Float(value.translation.height), 0]

//                            gameo.?.x = value.gestureValue.location
                            //                            value.translation
                        })
                )
            
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
