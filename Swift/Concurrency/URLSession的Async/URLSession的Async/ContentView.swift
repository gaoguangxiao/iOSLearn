//
//  ContentView.swift
//  URLSession的Async
//
//  Created by 高广校 on 2024/11/11.
//

import SwiftUI


struct URLSessionTools {

    let endpointURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv")!
    
    enum DogsError: Error {
        case invalidServerResponse
        case unsupportedImage
    }
    
    func featchPhoto(url: URL) async throws -> UIImage {
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode == 200 else {
            throw  DogsError.invalidServerResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw DogsError.unsupportedImage
        }
        
        return image
    }
    
    func onApperHandle() async throws -> Array<Any>{
        let (bytes, response) = try await URLSession.shared.bytes(from: endpointURL)
        
        guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode == 200 else {
            throw  DogsError.invalidServerResponse
        }
        
//        return /*by*/
        var lines: Array<Any> = []
        for try await line in bytes.lines {
//            let earthQu = JSONDecoder().dec
            print("line: \(line)")
            lines.append(line)
        }
        print("lines:\(lines.count)")
        return lines
//        URLSession.shared.data(from: endpointURL, delegate: self)
    }
    
    func e () {
        
        var colors: Deque = ["red", "yellow", "blue"]
        
    }
    
}

struct ContentView: View {
    
    let tools = URLSessionTools()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button {
                Task {
                    print("before")
                    //任务会被挂起，after会在awit之后执行
                    let lines = try? await tools.onApperHandle()
                    print("after")
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
