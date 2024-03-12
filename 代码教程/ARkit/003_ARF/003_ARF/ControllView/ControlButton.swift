//
//  ControlButton.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct ControlButton: View {
    
    let systemIconName: String
    
    let action: ()-> Void
    
    var body: some View {
         
        Button(action: {
            self.action()
            
        }, label: {
            Image(systemName: systemIconName)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(.plain)
        })
        .frame(width: 50,height: 50)
        
    }
}
