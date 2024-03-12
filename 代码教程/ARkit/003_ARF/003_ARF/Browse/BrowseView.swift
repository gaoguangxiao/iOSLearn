//
//  BrowseView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/23.
//

import SwiftUI

struct BrowseView: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        
//        if #available(iOS 16.0, *) {
//            NavigationStack {
//                ScrollView {
//                    ModelsByCategoryGrid(showBrowse: $showBrowse)
//                }
//                .navigationBarTitle("Browse",displayMode: .large)
//                .navigationBarItems(trailing:
//                                        
//                                        Button(action: {
//                    self.showBrowse.toggle()
//                }, label: {
//                    Text("Done").bold()
//                }))
//            }
//        } else {
            // Fallback on earlier versions
            NavigationView {
                ScrollView {
                    RecentsGrid(showBrowse: $showBrowse)
                    
                    ModelsByCategoryGrid(showBrowse: $showBrowse)
                }
                .navigationBarTitle("Browse",displayMode: .large)
                .navigationBarItems(trailing:
    
                                        Button(action: {
                    self.showBrowse.toggle()
                }, label: {
                    Text("Done").bold()
                }))
            }
//        }
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

#Preview {
    BrowseView(showBrowse: .constant(false))
}
