//
//  ArrayBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/12.
//

import SwiftUI

struct ArrayBootCamp: View {
    
    let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
    
    let cast = ["Vivien", "Marlon", "Kim", "Karl"]

    var body: some View {
        VStack(spacing: 20, content: {

            Button(action: {
                minT()
            }, label: {
                Text("min")
            })
            
            Button(action: {
                maxT()
            }, label: {
                Text("max")
            })
            
            Button(action: {
                mapT()
            }, label: {
                Text("map")
            })
        })
    }
    
    func minT() {
        let lowestHeight = heights.min()
        print(String(reflecting: lowestHeight))
    }
    
    func maxT() {
        let greatestHeight = heights.max()
        print(String(reflecting: greatestHeight))
    }
    
    func mapT() {
        
        let lowercaseNames = cast.map { $0.lowercased()
        }
            
        let letterCounts = cast.map {
            $0.count
        }
     
        print("lowercaseNames: \(String(reflecting: lowercaseNames))")
        
        print("letterCounts: \(String(reflecting: letterCounts))")
        
        //操作集合中每个元素
    }
}

#Preview {
    ArrayBootCamp()
}
