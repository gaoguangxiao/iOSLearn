//
//  SliderBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct SliderBootcamp: View {
    @State var sliderValue : Double = 80.0
    
    @State var sliderColor: Color = .red
    var body: some View {
        
        VStack{
            Text("Rating:")
//            Text("\(sliderValue)")
            Text(
                String(format: "%.2f", sliderValue)
            )
            .foregroundColor(sliderColor)
            //            Slider(value:$sliderValue).accentColor(.red)
            //            Slider(value: $sliderValue, in: 0...100).accentColor(.red)
            //            Slider(value: $sliderValue, in: 0...100, step: 10).accentColor(.red)
            Slider(value: $sliderValue,
                   in: 1...5,
                   step: 1.0,
                   onEditingChanged: { (_) in
                sliderColor = .green
            },
                   minimumValueLabel: Text("1"),
                   maximumValueLabel: Text("5")) {
                Text("title")
            }.accentColor(.red)
        }
        
    }
}

#Preview {
    SliderBootcamp()
}
