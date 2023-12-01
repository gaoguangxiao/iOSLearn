//
//  TextfiledBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

//@FocusState
import SwiftUI

struct TextfiledBootcamp : View {
    
    @State var textfiledText: String = ""
    
    @State var dataArray :[String] = []
    
    @FocusState var textInFocus: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("type something here,,,", text:$textfiledText)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.red)
                .font(.headline)
                .focused($textInFocus)
                
                Button(action: {
                    if textIsApproprose() {
                        saveText()
                    }
                }, label: {
                    Text("save".uppercased())
                        .padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(textIsApproprose() ? Color.blue : Color.gray)
                        .foregroundStyle(.white)
                        .font(.headline)
//                        .cornerRadius(10) 将弃用的语法 Use `clipShape` or `fill` instead.
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))) //clipShape 传入形状，如原型，矩形，椭圆形等等
                })
                .disabled(!textIsApproprose())
                
                ForEach(dataArray, id: \.self) { data in
                    Text(data)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Textfield Bootcamp!")
            .onAppear(perform: {
                textInFocus = true
            })
        }
    }
    
    func textIsApproprose() -> Bool {
        if textfiledText.count >= 3 {
            return true
        }
        return false
    }
    
    func saveText() {
        dataArray.append(textfiledText)
        
        textfiledText = ""
    }
}

#Preview {
    TextfiledBootcamp()
}
