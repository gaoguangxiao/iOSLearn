//
//  PlantSummaryRow.swift
//  Xcode-01
//
//  Created by 高广校 on 2024/6/20.
//

import Foundation
import SwiftUI

// 1.代码自动提示，将PlantSummaryRow作为类型名称，因为创建文件的名称为这个
struct PlantSummaryRow: View {
    /// 实体
    var body: some View {
        VStack {
            
            Text("G")
                .font(.title)
                .bold()
                
        }
        //1、提示中，按下键盘 ->
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PlantSummaryRow()
}
