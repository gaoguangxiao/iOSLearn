//
//  EViewController.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2024/6/13.
//  修复方案：子线程创建的Timer，在子线程中销毁，确保线程安全
//  使用 DispatchQueue + CFRunLoopPerformBlock 投递
//

import UIKit

class EViewController: UIViewController {
    
    var subTimer: Timer?
    let subQueue = DispatchQueue(label: "com.timer.subQueue")
    /// 保存子线程的 RunLoop 引用，用于后续唤醒投递任务
    var subRunLoop: RunLoop?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "子线程Timer正确销毁(Dispatch)"
        
        subQueue.async { [weak self] in
            guard let self = self else { return }
            Thread.current.name = "SubTimerQueue"
            
            // 保存当前子线程的 RunLoop
            self.subRunLoop = RunLoop.current
            
            self.subTimer = Timer(timeInterval: 1.0, repeats: true, block: { timer in
                print("子线程Timer触发 - 当前线程: \(Thread.current.name ?? "unknown")")
            })
            
            RunLoop.current.add(self.subTimer!, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent || self.isBeingDismissed {
            print("准备销毁子线程Timer - 当前线程: \(Thread.current.name ?? "unknown")")
            
            // 通过 CFRunLoopPerformBlock 向子线程 RunLoop 投递任务
            // 不走 GCD 队列，直接通过 RunLoop Source 机制投递
            if let runLoop = subRunLoop {
                CFRunLoopPerformBlock(runLoop.getCFRunLoop(), CFRunLoopMode.commonModes?.rawValue) { [weak self] in
                    guard let self = self else { return }
                    print("在子线程中销毁Timer - 当前线程: \(Thread.current.name ?? "unknown")")
                    self.subTimer?.invalidate()
                    self.subTimer = nil
                    CFRunLoopStop(CFRunLoopGetCurrent())
                    print("子线程RunLoop已停止")
                }
                // 唤醒子线程 RunLoop，让它立即处理投递的 block
                CFRunLoopWakeUp(runLoop.getCFRunLoop())
            }
        }
    }
    
    deinit {
        print("\(self)-deinit")
    }
}
