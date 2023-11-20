//
//  StepperBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct StepperBootcamp: View {
    @State var stepperValue : Int = 10
    
    @State var widthValue : CGFloat = 10.0
    
    var body: some View {
        Stepper("Stepper:\(stepperValue)", value: $stepperValue)
            .padding()
        
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(width: 100 + widthValue,height: 100)
        
        Stepper("Stepper:2 ") {
            incrementWidth(width: +10)
        } onDecrement: {
            incrementWidth(width: -10)
        }
    }
    
    func incrementWidth(width:CGFloat){
        withAnimation(.easeInOut) {
            widthValue+=width
        }
    }
}

#Preview {
    StepperBootcamp()
}
