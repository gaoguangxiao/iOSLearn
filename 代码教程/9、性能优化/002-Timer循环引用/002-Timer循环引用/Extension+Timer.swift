//
//  Extension+Timer.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2023/12/21.
//

import Foundation

extension Timer {
    
    /// Timer将userInfo作为callback的定时方法
    /// 目的是为了防止Timer导致的内存泄露
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复
    ///   - callback: 回调方法
    /// - Returns: Timer
    public static func zk_scheduledTimer(timeInterval: TimeInterval, repeats: Bool, with callback: @escaping () -> Void) -> Timer {
        return scheduledTimer(timeInterval: timeInterval,
                              target: self,
                              selector: #selector(callbackInvoke(_:)),
                              userInfo: callback,
                              repeats: repeats)
    }
    
    /// 私有的定时器实现方法
    ///
    /// - Parameter timer: 定时器
    @objc
    private static func callbackInvoke(_ timer: Timer) {
        guard let callback = timer.userInfo as? () -> Void else { 
            print("未实现timer.userInfo方法")
            return
        }
        callback()
    }
    
}
