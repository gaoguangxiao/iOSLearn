//
//  SettingsView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View {
        
//        SettingsGrid()
        NavigationView {
            
            SettingsGrid()
                .navigationBarTitle("Settings",displayMode: .inline)
                .navigationBarItems(trailing:
                                        
                                        Button(action: {
                    
                    self.showSettings.toggle()
                    
                }, label: {
                    Text("Done").bold()
                }))
        }
    }
}

#Preview {
    SettingsView(showSettings: .constant(true))
        .environmentObject(SessionSettings())
}
