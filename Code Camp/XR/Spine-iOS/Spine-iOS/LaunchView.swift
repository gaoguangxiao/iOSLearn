//
//  LaunchView.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/14.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink {
                        SpineListUIView()
                    } label: {
                        Text("Demo-列表")
                    }
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Demo演示-全")
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
