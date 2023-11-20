//
//  TapGestureBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct TapGestureBootcamp: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 40, content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
       
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(height: 200)
                .foregroundColor(isSelected ? Color.green : Color.red)
            
            Button(action: {
                isSelected.toggle()
            }, label: {
                Text("Button")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                
            })
            
            Text("Tap Gesture")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height:50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                .onTapGesture {
//                    isSelected.toggle()
//                }
                .onTapGesture(count: 3, perform: {
                    isSelected.toggle()
                })
            
            Spacer()
            
        })
        .padding()
    }
}

#Preview {
    TapGestureBootcamp()
}
