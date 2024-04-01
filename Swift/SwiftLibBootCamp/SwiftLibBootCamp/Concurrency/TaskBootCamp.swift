//
//  TaskBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import SwiftUI

struct TaskBootCamp: View {
    
   
    
    var body: some View {
        
        Button(action: {
            click()
        }, label: {
            Text("点击")
        })
  
    }
    
//    @attached(peer,names: overloaded)
//    macro addComplete(para: String = "ABC")
    
    func click() {
        let basic = Task {
            return "This is the result of the task"
        }
        Task {
            print("Task: \(await basic.value)")
            //Task: This is the result of the task
        }
        
//        Task.detached {
            
//        }
    }
}

#Preview {
    TaskBootCamp()
}
