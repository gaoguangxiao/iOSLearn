//
//  TimerBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct TimerBootcamp: View {
    
    @State var timeRemaining: Int = 60
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack{
            HStack {
                Button(action: {
                    startTimer()
                }, label: {
                    Text("start")
                })
                
                Button(action: {
                    stopTimer()
                }, label: {
                    Text("end")
                })
                
                Button(action: {
                    stopTimer()
                }, label: {
                    Text("reset")
                })
            }
                    
            Text("Time Remaining：\(timeRemaining)")
                .onReceive(timer, perform: { _ in
                    timeRemaining -= 1
                })
                .onAppear(perform: { //修饰视图加载启动计时器
                    timeRemaining = 60
                })
        }
        
    }
    
    func startTimer() {
        //        timer.upstream.s
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func resetTimer() {
        timeRemaining = 60
        timer.upstream.connect().cancel()
    }
}

#Preview {
    TimerBootcamp()
}
