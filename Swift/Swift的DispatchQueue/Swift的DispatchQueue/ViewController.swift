//
//  ViewController.swift
//  Swift的DispatchQueue
//
//  Created by 高广校 on 2024/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        let concurrentQueue = DispatchQueue(label: "ggx.concurrent.queue",attributes: .concurrent)
        concurrentQueue.async {
            print("Task 1 started")
            // Do some work..
            print("Task 1 finished")
        }
        concurrentQueue.async {
            print("Task 2 started")
            // Do some work..
            print("Task 2 finished")
        }
        
//        concurrentQueue.sync(flags: .barrier) {
//            
        }
    }
    
    func createSerialQueue()  {
        let serialQueue = DispatchQueue(label: "ggx.serial.queue")
        
        serialQueue.async {
            print("Task 1 started")
            // Do some work..
            print("Task 1 finished")
        }
        serialQueue.async {
            print("Task 2 started")
            // Do some work..
            print("Task 2 finished")
        }
    }
    
}

