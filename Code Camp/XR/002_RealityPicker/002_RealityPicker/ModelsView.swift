//
//  ModelsView.swift
//  002_RealityPicker
//
//  Created by 高广校 on 2024/8/1.
//

import SwiftUI

struct ModelsView: View {
    
    var models: [String]
    
    var action: (String) -> Void?
    
    var body: some View {
        
        Spacer()
        
        ScrollView(.horizontal) {
            HStack(spacing: 30, content: {
                
                ForEach(models, id: \.self) { model in
                    
                    Button(action: {
                        print("点击")
                        self.action(model)
                    }, label: {
                        Image(model, bundle: .main)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fill)
                            .background(Color.white)
                            .cornerRadius(12)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            })
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

let models = ["biplane",
              "robot_walk_idle",
              "teapot",
              "drummertoy",
              "retrotv"]

#Preview {

    ModelsView(models: models) { _ in
        
    }
}
