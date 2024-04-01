//
//  ClockBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import SwiftUI

struct ClockBootCamp: View {
    var body: some View {
        
        Button(action: {
            click()
        }, label: {
            Text("点击")
        })
        
        Button(action: {
            click1()
        }, label: {
            Text("是否堵塞")
        })
        
        Button(action: {
            ContinuousClockT()
        }, label: {
            Text("Continuous")
        })
        
        Button(action: {
            ContinuousClockC()
        }, label: {
            Text("测量")
        })
    }
    
    func ContinuousClockC() {
        let continuousClock = ContinuousClock()
        // 测量
        let elapsed = continuousClock.measure {
            //执行复杂的任务
            someWork()
        }
        print("elapsed: \(elapsed.components.seconds)")
    }
    
    func someWork() {
        print("sleep before")
        sleep(4)
        print("sleep after")
    }
    
    func ContinuousClockT() {
        
        //
        // let n = ContinuousClock.now
        // print("ContinuousClock.now: \(n)")
        
        let t = ContinuousClock.Instant.now
        print("now: \(t.self)")
        
        //当前时间 + 3秒
//        let fs = t + Duration.seconds(3)
//        print("ContinuousClock.Instant.now + 3: \(fs)")
        
        //当前时间 + 50毫秒
        let microseconds = Duration.microseconds(50)
        print("microseconds: \(microseconds)")
        let fmcro = t + microseconds
        print("ContinuousClock.Instant.now + 50sss: \(fmcro)")
        
        let milliseconds = Duration.milliseconds(50)
        print("milliseconds: \(milliseconds)")
    }
    
    func click() {
        
        //        /**
        //          不会堵塞
        //         */
        //        Task {
        //            print("sleep 1s-")
        //            try await Task.sleep(until: .now + .seconds(1))
        //            print("sleep 1s")
        //        }
        
        // 异步
                Task {
                    print("sleep before")
                    try await Task.sleep(until: .now + .seconds(1),clock: .suspending)
                    print("sleep after")
                }
        
        
    }
    
    func click1() {
        print("click1")
    }
}

#Preview {
    ClockBootCamp()
}
