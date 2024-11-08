//
//  ViewController.swift
//  Swift的Task
//
//  Created by 高广校 on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        任务可以在创建后立即开始运行;你没有明确地开始或安排它们,创建任务后，使用实例与之交互——例如，等待任务完成或取消任务
        let basicTask = Task {
            return "This is the result of the task"
        }
        
        basicTask.cancel()
        
        //不支持并发的函数中 使用 await是常用的错误
        Task {
            print(await basicTask.value)
        }
        
        ///`detached`方法创建一个独立的一部任务
        Task.detached {
            print(await basicTask.value)
        }
    }
    
    func TestAsyncTask() async {
        
        async let result = URLSession.shared.data(from: URL(string: "")!)
        
    }
}

