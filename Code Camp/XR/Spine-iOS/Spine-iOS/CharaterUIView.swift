//
//  CharaterUIView.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import SwiftUI
import Spine

struct CharaterUIView: View {
    
    @StateObject
    var source = SkeletonSource()
    
    var body: some View {
        List {
            if let datas = source.datas {
                ForEach(datas) { datum in
                    HStack {
                        if let name = datum.name {
                            Text("\(name)")
                        }
                        if let atlas = datum.atlas ,let json = datum.json {
                            
                            SkeletonUIView(datum: datum)
                            
                            VStack {
                                Text("From-File")
                                if let atlasPath = Bundle.main.path(forResource: atlas, ofType: nil),
                                   let jsonPath = Bundle.main.path(forResource: json, ofType: nil) {
                                    SpineView(from: .file(atlasFile: URL(fileURLWithPath: atlasPath),
                                                          skeletonFile: URL(fileURLWithPath: jsonPath)))
                                    .frame(height: 100)
                                }
                            }
                        }
                        //网络spine资源为4.1.23-本地4.2。
//                        if let atlasURL = datum.atlasURL,
//                           let atlasHTTPURL = URL(string: atlasURL),
//                           let jsonURL = datum.jsonURL,
//                           let jsonHTTP = URL(string: jsonURL){
//                            VStack {
//                                Text("From-URL")
//                                SpineView(from: .http(atlasURL: atlasHTTPURL, skeletonURL: jsonHTTP))
//                                    .frame(height: 100)
//                            }
//                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            source.loadCharaterJSON()
        }
    }
}

#Preview {
    CharaterUIView()
}
