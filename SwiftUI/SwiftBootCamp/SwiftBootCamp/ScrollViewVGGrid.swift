//
//  ScrollViewVGGrid.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnable: Bool = false
    @Published var isObjectOcclusionEnable: Bool = false
    @Published var isLidarDebugEnable: Bool = false
    @Published var isMultiuserEnable: Bool = false
}

struct ScrollViewVGGrid: View {
    
    @StateObject var sessionSettings = SessionSettings()
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100),spacing: 25)]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: gridItemLayout, content: {
                ItemButton(isOn: $sessionSettings.isPeopleOcclusionEnable,systemIconName: "light.min")
                ItemButton(isOn: $sessionSettings.isObjectOcclusionEnable, systemIconName: "cube.box.fill")
                ItemButton(isOn: $sessionSettings.isLidarDebugEnable, systemIconName: "light.min")
                ItemButton(isOn: $sessionSettings.isMultiuserEnable, systemIconName: "person.2")
            })
        }
    }
}

#Preview {
    ScrollViewVGGrid()
}

struct ItemButton: View {
    
    @Binding var isOn: Bool
    
    let systemIconName: String
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }, label: {
            VStack {
                Image(systemName: systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(.plain)
                
                Text("Occlusin")
                    .font(.system(size: 17,weight: .medium,design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top,5)
            }
        })
        .frame(width: 100,height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20)
    }
}
