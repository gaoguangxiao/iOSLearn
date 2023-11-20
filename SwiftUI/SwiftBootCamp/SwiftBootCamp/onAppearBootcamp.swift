//
//  onAppearBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct onAppearBootcamp: View {
    
    @State var myText: String = "Start text."
    
    @State var count: Int = 0
    var body: some View {
        
        NavigationView {
            ScrollView {
                Text(myText)
                
                LazyVStack {
                    ForEach(0..<50) { (_) in
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(height: 200)
                            .onAppear(perform: {
                                count += 1
                            })
                    }
                }
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    myText = "This is the new text!"
                }
            })
            .navigationTitle("On Appeae:\(count)")
        }
    }
}

#Preview {
    onAppearBootcamp()
}
