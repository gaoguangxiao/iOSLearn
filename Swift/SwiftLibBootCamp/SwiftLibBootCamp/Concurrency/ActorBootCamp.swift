//
//  ActorBootCamp.swift
//  SwiftLibBootCamp
//
//  Created by 高广校 on 2024/3/13.
//

import SwiftUI
import Combine
final class ChickenFeederWithQueue: ObservableObject {
    
    let food = "worms"
    
    /// 私有支持属性和计算属性的组合允许同步访问。
    private var _numberOfEatingChickens: Int = 0
    
    var numberOfEatingChickens: Int {
        queue.sync {
            _numberOfEatingChickens
        }
    }
    
    /// 一个并发的队列，允许同时进行多次读取。
    private var queue = DispatchQueue(label: "chicken.feeder.queue", attributes: .concurrent)
    
    func chickenStartsEating() {
        /// 使用栅栏阻止写入时的读取
        queue.sync(flags: .barrier) {
            _numberOfEatingChickens += 1
        }
    }
    
    
    func chickenStopsEating() {
        
        
        /// 使用栅栏阻止写入时的读取
        queue.sync(flags: .barrier) {
            _numberOfEatingChickens -= 1
        }
    }
}

actor ChickenFeeder {
    let food = "worms"
}

struct ActorBootCamp: View {
    
    @State var num: Int?
    
    let child = ChickenFeederWithQueue()
    
    let timer = Timer.publish(every: 0.01, on: RunLoop.current, in: .common)
    
    var cancellable: Cancellable?
    
    var body: some View {
        VStack(spacing: 30, content: {
            
            Button {
                for i in 0..<150 {
                    child.chickenStartsEating()
                }
                //                child.chickenStartsEating()
            } label: {
                Text("喂养开始")
            }
            
            Button {
                for i in 0..<100 {
                    child.chickenStopsEating()
                }
            } label: {
                Text("喂养停止")
            }
            
            Text("小鸡喂食数目：\(num ?? 0)")
            
            Button {
                updateData {
                    print(Thread.current)
                }
            } label: {
                Text("测试MainActor线程")
            }
            
            Button(action: {
                updateDataNoMainActor {
                    print(Thread.current)
                }
            }, label: {
                Text("测试No-MainActor线程")
            })
            
            Button(action: {
                updateDataNoMainActor {
                    Task {
                        await MainActor.run {
                            print(Thread.current)
                        }
                    }
                }
            }, label: {
                Text("测试No-MainActor-调度方线程")
            })
            
        })
        .onReceive(timer, perform: { _ in
            //            num = child.numberOfEatingChickens
            //            print(num)
        })
        .onAppear(perform: {
            //            self.start()
        })
        
    }
    
    func start()  {
        timer.connect()
    }
    
    func updateData(completion: @MainActor @escaping () -> ()) {
        /// Example dispatch to mimic behaviour
        DispatchQueue.global().async {
            Task { await completion() }
        }
    }
    
    func updateDataNoMainActor(completion: @escaping () -> ()) {
        DispatchQueue.global().async {
            completion()
        }
    }
    

    
}

#Preview {
    ActorBootCamp()
}
