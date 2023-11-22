//
//  ColorPickerBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/21.
//

import SwiftUI

struct ColorPickerBootcamp: View {
    
    @State var backgroundColor: Color = .green
    
    var body: some View {
        
        ZStack {
            
            backgroundColor
                .ignoresSafeArea()
            
            ColorPicker("Select a Color",
                        selection: $backgroundColor,
            supportsOpacity:true)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.headline)
            .padding(50)
            
//            Spacer()
        }
        
        
        
        
    }
}

#Preview {
    ColorPickerBootcamp()
}
