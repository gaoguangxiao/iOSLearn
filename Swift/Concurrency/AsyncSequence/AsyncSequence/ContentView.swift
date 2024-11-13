//
//  ContentView.swift
//  AsyncSequence
//
//  Created by 高广校 on 2024/11/11.
//

import SwiftUI

struct QuakesTools {
    
    let endpointURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv")!
    
    func testLines() {
        let lines = endpointURL.lines
        print(lines)
    }
    
    func testDropFirst() async throws {
        let dropFirst = try await endpointURL.lines.dropFirst()
        print(dropFirst)
    }
    
    func testAsyncSequence() async throws {
        for try await event in endpointURL.lines.dropFirst() {
            let values = event.split(separator: ",")
            print("values: \(values)")
        }
    }
    
    func asyncStream(){
//        AsyncStream
    }
    
}

struct ContentView: View {
    
    let tools = QuakesTools()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button {
                tools.testLines()
            } label: {
                Text("url-lines")
            }
            
            Button {
//                tools.testDropFirst()
            } label: {
                Text("url-testDropFirst")
            }
            
            Button {
                Task {
                    try? await tools.testAsyncSequence()
                }
            } label: {
                Text("load")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
