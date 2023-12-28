//
//  TimerBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/20.
//

import SwiftUI

struct TimerBootcamp: View {
    
    @State var timeRemaining: Int = 0
    
    //autoconnect() 标记立即运行
    @State var timer = Timer.publish(every: 1, 
                                     on: .main,
                                     in:.common).autoconnect()
    
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
              
            //使用Timer的情况下，我们需要使用名为`onReceive`手动捕获公告
            Button(action: {
                
                startTimer()
                
            }, label: {
                Text(timeRemaining > 0 ? "\(timeRemaining)S":"发送验证码")
                    .padding(EdgeInsets(top: 10, leading: 01, bottom: 10, trailing: 5))
                    .background(Color.red)
                    .onReceive(timer, perform: { time in
                        if timeRemaining >= 0 {
                            timeRemaining -= 1
                        } else {
//                            time.
                            timeRemaining = 60
                        }
                    })
            })
            .frame(minWidth: 80)
            
            
//            Text("Time Remaining：\(timeRemaining)")
//                .onReceive(timer, perform: { _ in
//                    timeRemaining -= 1
//                })
//                .onAppear(perform: { //修饰视图加载启动计时器
//                    timeRemaining = 60
//                })
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
        timer.upstream.connect()
    }
}

#Preview {
    TimerBootcamp()
}
