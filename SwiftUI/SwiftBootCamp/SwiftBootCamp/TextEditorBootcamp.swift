//
//  TextEditorBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct TextEditorBootcamp: View {
    
    @State var textEditorText: String = "This is the starting text"
    
    @State var savedText: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextEditor(text: $textEditorText)
                    .frame(height: 250)
                    .colorMultiply(Color.secondary).cornerRadius(10)
                
                Button(action: {
                    savedText = textEditorText
                }, label: {
                    Text("save".uppercased())
                        .font(.headline)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                })
                
                Text(savedText)
                
                Spacer()
            }
            .padding()
            .navigationTitle("TextEditor Bootcamp!")
        }
        
    }
    
    
}

#Preview {
    TextEditorBootcamp()
}
