//
//  ContentView.swift
//  Swift的Actor
//
//  Created by 高广校 on 2024/6/24.
//

import SwiftUI

class Counter {
    var value = 0
    
    func increment() -> Int {
        value = value + 1
        return value
    }
}

struct ContentView: View {
    
    let counter = Counter()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                
                addcre()
                
            } label: {
                
                Text("数据竞争案例")
                
            }
            
        }
        .padding()
    }
    
    func addcre() {
        let counter = Counter()
        
        print("案例------")
        Task.detached {
            print(counter.increment()) // data race
        }
        
        Task.detached {
            print(counter.increment()) // data race
        }
//        案例------
//        2
//        1
        
//        案例------
//        1
//        1
  
//        案例------
//        1
//        2
    }
}

#Preview {
    ContentView()
}
