//
//  DViewController.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2024/6/13.
//  验证：子线程创建的Timer，在不在同一线程销毁，是否会闪退
//  使用 DispatchQueue 演示
//

import UIKit

class DViewController: UIViewController {
    
    var subTimer: Timer?
    let subQueue = DispatchQueue(label: "com.timer.subQueue")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "子线程Timer跨线程销毁(Dispatch)"
        
        // 使用 DispatchQueue 在子线程创建 Timer
        subQueue.async { [weak self] in
            guard let self = self else { return }
            Thread.current.name = "SubTimerQueue"
            
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
            // 错误做法：在主线程销毁子线程的 Timer
            print("准备在主线程销毁子线程的Timer - 当前线程: \(Thread.current.name ?? "unknown")")
            subTimer?.invalidate()
            subTimer = nil
            print("Timer已销毁 - 当前线程: \(Thread.current.name ?? "unknown")")
        }
    }
    
    deinit {
        print("\(self)-deinit")
    }
}
