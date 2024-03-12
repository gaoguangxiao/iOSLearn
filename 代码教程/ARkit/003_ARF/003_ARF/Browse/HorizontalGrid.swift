//
//  HorizontalGrid.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct HorizontalGrid: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @Binding var showBrowse: Bool
    
    var title: String
    var items: [Model]
    
    private let gridItemLayout =  [GridItem(.fixed(150))]
    
    var body: some View {
        
        VStack(alignment: .leading) {
          
            Separator()
            
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHGrid(rows: gridItemLayout, content: {
                    
                    ForEach(0..<items.count) { index in
                        
                        let model = items[index]
                        ItemButton(model: model) {
                            //选择
                            print("selected :\(model.name)--位置\(index)")
                            
                            model.asyncLoadModeEntity()
                            
                            self.placementSettings.selectedModel = model
                            //隐藏抽屉
                            self.showBrowse.toggle()
                        }
//                        Color(UIColor.secondarySystemFill)
//                            .frame(width: 150,height: 150)
//                            .cornerRadius(8)
                    }

                })
                .padding(.horizontal, 22)
                .padding(.vertical, 30)
            }
        }
    }
}


//#Preview {
//    HorizontalGrid()
//}
