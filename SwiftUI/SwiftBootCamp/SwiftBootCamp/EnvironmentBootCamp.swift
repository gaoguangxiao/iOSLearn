//
//  EnvironmentBootCamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2024/3/28.
//

import SwiftUI

struct EnvironmentBootCamp: View {
    
    @Environment(\.truncationMode) var truncationMode: Text.TruncationMode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .environment(\.font, .largeTitle)
    }
}

#Preview {
    EnvironmentBootCamp()
}
