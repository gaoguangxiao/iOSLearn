//
//  DebugRendering.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/22.
//

import SwiftUI

struct DebugRendering: View {
    
    @StateObject
    var skeletonScript = SkeletonGraphicScript()
    
    @StateObject
    var source = SkeletonSource()
    
    @State
    var rect: CGRect?
    
    var body: some View {
                
        ZStack {
            Text("Hello, World!")
            
            if let spineView = skeletonScript.spineView {
                spineView
                    .frame(width: 200,height: 200)
                    .background(Color.gray)
                    .padding()
            }
            
            if let rect {
                Rectangle()
                    .fill(.red)
                    .offset(x:rect.minX,y:rect.midY)
                    .frame(width: 10,height: 10)
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
        .onTapGesture {
//            skeletonScript.getBoneRectBy(boneName: "root")
            
            if let rect = skeletonScript.getBoneRectBy(boneName: "root") {
                self.rect = CGRect(x: rect.minX,
                                   y: rect.midY,
                                   width: rect.width,
                                   height: rect.height)
//                let rView = UIView()
//                rView.frame = rect
//                rView.backgroundColor = .red
//                spineView.addSubview(rView)
//                
//                let vRview = UIView()//self.view添加根节点
//                vRview.frame = rect
//                vRview.backgroundColor = .red
//                view.addSubview(vRview)
            } else {
                print("get bone rect is nil")
            }
        }
    }
}

#Preview {
    DebugRendering()
}
