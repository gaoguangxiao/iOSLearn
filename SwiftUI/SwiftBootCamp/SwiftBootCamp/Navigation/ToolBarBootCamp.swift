//
//  ToolBarBootCamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct ToolBarBootCamp: View {
    
    @Binding var text: String
    
    @State private var fontSize = 12.0
    @State private var bold = false
    @State private var italic = false
    
    var displayFont: Font {
            let font = Font.system(size: CGFloat(fontSize),
                                   weight: bold == true ? .bold : .regular)
            return italic == true ? font.italic() : font
        }
    
    var body: some View {
    
  
        NavigationView {
            Text("A")
                .toolbar {
                    ToolbarItemGroup {
    
                        Slider(value: $fontSize,
                               in: 8...120,
                               minimumValueLabel: Text("A").font(.system(size: 8)), maximumValueLabel: Text("A").font(.system(size: 16))
                        ) {
                            Text("Font size (\(Int(fontSize))")
                        }
                        .frame(width: 150)
    
                        ///
                        Toggle(isOn: $bold, label: {
                            Image(systemName: "bold")
                        })
    
                        Toggle(isOn: $italic, label: {
                            Image(systemName: "italic")
                        })
                    }
                }
        }
        
       
//        TextEditor(text: $text)
//            .font(displayFont)
//            .toolbar {
//                ToolbarItemGroup {
//                    
//                    Slider(value: $fontSize,
//                           in: 8...120,
//                           minimumValueLabel: Text("A").font(.system(size: 8)), maximumValueLabel: Text("A").font(.system(size: 16))
//                    ) {
//                        Text("Font size (\(Int(fontSize))")
//                    }
//                    .frame(width: 150)
//                    
//                    ///
//                    Toggle(isOn: $bold, label: {
//                        Image(systemName: "bold")
//                    })
//                    
//                    Toggle(isOn: $italic, label: {
//                        Image(systemName: "italic")
//                    })
//                }
//            }
//            .navigationTitle("My Note")
    }
}

#Preview {
    ToolBarBootCamp(text: .constant("toolBar"))
}
