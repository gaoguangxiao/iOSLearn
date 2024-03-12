//
//  ModelsByCategoryGrid.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct ModelsByCategoryGrid: View {
    
    @Binding var showBrowse: Bool
    
    let models = Models()
    
    var body: some View {
     
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                
                if let modelsByCategory = models.get(category: category) {
                    HorizontalGrid(showBrowse: $showBrowse,title: category.label, items: modelsByCategory)
                }
            }
        }
    }
}


#Preview {
    ModelsByCategoryGrid(showBrowse: .constant(true))
}
