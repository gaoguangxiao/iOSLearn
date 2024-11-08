//
//  ContentView.swift
//  Swift的Actor
//
//  Created by 高广校 on 2024/6/24.
//

import SwiftUI

struct Counter {
    var value = 0
    
    var ud: String
    
    mutating func increment() -> Int {
        value = value + 1
        return value
    }
}

//引用类型，表达共享的可变状态
//actor确保不会同时访问该值
actor AcCounter {
    var value = 0
    var ud: String = "a"
    func increment() -> Int {
        value = value + 1
        return value
    }
}

extension AcCounter {
    func resetSlowly(to newValue: Int) {
        value = 0
        for _ in 0..<newValue {
            increment()
        }
        assert(value == newValue)
    }
}

struct ContentView: View {
        
    var body: some View {
        VStack {
            
            Button {
                addcre()
            } label: {
                Text("struct数据竞争")
            }
            
            Button {
                addAcCrement()
            } label: {
                Text("actor数据竞争")
            }
            
            Button {
                testArc2()
            } label: {
                Text("actor-2")
            }
        }
        .padding()
    }
    
    func testArc2() {
        let counter = AcCounter()
        Task.detached {
            await counter.resetSlowly(to: 10)
            print(await counter.value)
        }
       
    }
    
    func addAcCrement() {
        let counter = AcCounter()
        print("actor案例: \(counter.ud)")
        Task.detached {
             print(await counter.increment()) // await表示duiAtor的异步调用
        }
        
        Task.detached {
             print(await counter.increment()) // data race
        }
    }
    
    func addcre() {
        
//        for i in 0...100 {
//            var counter = Counter(ud: "\(i)")
//            print("案例: \(counter.ud)")
//            Task.detached {
//                print(counter.increment()) // data race
//            }
//            
//            Task.detached {
//                print(counter.increment()) // data race
//            }
//        }
//        
        var counter = Counter(ud: "\(1)")
        print("案例: \(counter.ud)")
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
