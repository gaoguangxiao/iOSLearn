//
//  ViewController.swift
//  003_runloop观察
//
//  Created by 高广校 on 2023/12/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //监听运行循环事件
        let runloop = CFRunLoopGetCurrent()
//        RunLoop.current.getCFRunLoop()
    
        let actitities = CFRunLoopActivity.allActivities //actitities 传入要监听的所有状态
        let allocator =  CFAllocatorGetDefault().takeUnretainedValue()
        let observer =  CFRunLoopObserverCreateWithHandler(allocator,
                                                           actitities.rawValue,
                                                           true,
                                                           0) { observer, activity in
            switch activity {
            case .entry :
                print("进入runloop循环")
            case .beforeTimers:
                print("即将处理timers")
            case .beforeSources:
                print("即将处理Source")
            case .beforeWaiting:
                print("即将休眠")
            case .afterWaiting:
                print("刚从休眠唤醒")
            case .exit:
                print("runloop循环结束")
            default:
                break
            }
        }
        CFRunLoopAddObserver(runloop, observer, .defaultMode)
//        CFGetRetainCount(<#T##cf: CFTypeRef!##CFTypeRef!#>)
    }


}

