//
//  ItemButton.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct ItemButton: View {
    let model: Model
    let action: ()-> Void
    var body: some View {
        
        Button(action: {
            self.action()
        }, label: {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1,contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
        })
    }
}

//#Preview {
//    ItemButton()
//}
