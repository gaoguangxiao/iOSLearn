//
//  ObservationBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import SwiftUI

class ObCountModel: ObservableObject {
  
    @Published var count: Int = 0
}


@Observable class ObCount5_9Model {
    var count: Int = 0
}

struct ObservationBootCamp: View {
    
    //初始化使用
   @StateObject var model = ObCountModel()

    var model5_9 = ObCount5_9Model()
    
    var body: some View {
        VStack(content: {
            
            Button(action: {
                
                /**
                 old
                 */
//                model.count += 1
                
                model5_9.count += 1
                print("add")

            }, label: {
                Text("add")
            })
            
            Text("count is：\(model5_9.count)")
//            Text("count is：\(model.count)")
        })
        
    }
}

#Preview {
    ObservationBootCamp()
}
