//
//  AsyncSequenceBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/14.
//

import SwiftUI

struct Counter: AsyncSequence {
    
    typealias Element = Int
    
    let howHigh: Int
    
    struct AsyncIterator: AsyncIteratorProtocol {
    
        let howHigh: Int
       
        var current = 1
        
        mutating func next() async throws -> Element? {
            guard !Task.isCancelled else {
                return nil
            }
            guard current <= howHigh else {
                return nil
            }
            let result = current
            current += 1
            return result
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(howHigh: howHigh)
    }
}

struct AsyncSequenceBootCamp: View {
    var body: some View {
        
        VStack(content: {
            
            Button(action: {
                click()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        })
    }
    
    func click() {
        
//        Task {
//            for try await number in Counter(howHigh: 10) {
//              print(number, terminator: " ")
//            }
//        }
//        1 2 3 4 5 6 7 8 9 10
        
//---------------------------
        Task {
            for try await number in Counter(howHigh: 10).filter({$0 % 2 == 0}){
              print(number, terminator: " ")
            }
        }
//        2 4 6 8 10
        
    }
}

#Preview {
    AsyncSequenceBootCamp()
}
