//
//  ViewController.swift
//  Swift的MainActor
//
//  Created by 高广校 on 2024/6/24.
//

import UIKit

//@MainActor
class MyModel {

    static let shared = MyModel()
    
    init() {
        MainActor.assertIsolated()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let model = await MyModel.shared
        
        let concurrentQueue = DispatchQueue(label: "ggx.concurrent.queue",attributes: .concurrent)
        
        concurrentQueue.async {
            print("thread is: \(Thread.current)")
        }
        
        Task {
            await MainActor.run {
                print("MainActor thread is: \(Thread.current)")
            }
        }
        
//        == 标记某方法在主线程执行
        async {
            await MainActor.run {
                print("MainActor2 thread is: \(Thread.current)")
            }
        }
    }


}

