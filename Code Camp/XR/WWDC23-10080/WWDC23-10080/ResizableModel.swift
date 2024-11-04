//
//  ResizableModel.swift
//  004-SwiftUIRealityKit
//
//  Created by 高广校 on 2024/8/9.
//

import SwiftUI
import RealityKit

struct ResizableModel: View {
    var body: some View {
        GeometryReader3D { geometry in
            RealityView { content in
                if let earth = try? await ModelEntity(named: "Earth") {
                    let bounds = content.convert(geometry.frame(in: .local),
                                                 from: .local, to: content)
                    let minExtent = bounds.extents.min()
                    //对加载后的实体进行缩放
                    earth.scale = [minExtent, minExtent, minExtent]
                    content.add(earth)
                }
            }
        }
    }
}

#Preview {
    ResizableModel()
}
