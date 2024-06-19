//
//  ViewController.swift
//  Swift的Async和Await
//
//  Created by 高广校 on 2023/11/15.
// https://juejin.cn/post/6844903937032601614

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        testAsync()
        
        /**
         
         结构化并发：执行顺序是线性的
         */
        
    }
    
    //async和await函数
    func testAsync()  {
        
        print("步骤1")
        
        //当试图从不支持并发的同步调用环境调用一个并发方法时，会出现`'async' call in a function that does not support concurrency`，如果将`testAsync`定义为异步，那么错误会转移到其他地方。可以使用`Task.init`方法
        //        let d = await fetchWeatherHistory()
        
        if #available(iOS 13.0, *) {

            Task.init {
                //await：告诉程序等待返回结果，只有结果达到之后才能继续
                let d = await fetchWeatherHistory()
                print("步骤2")
//                calculateAverageTemperature(for: d) { d1 in
                    
//                }
//                let d1 = calculateAverageTemperature(for: d)
//                print("步骤3")
//                print(d1)
            }
//            let d1 = calculateAverage(for: [1])
//            let d1 = calculateAverageTemperature(for: [0])
            //                print("步骤3")
            //                print(d1)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //Swift5.5之后代码改进
    //    func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
    //        // 省略复杂的网络代码，这里我们直接用100000条记录来代替
    //        DispatchQueue.global().async {
    //            let results = (1...100).map { _ in
    //                Double.random(in: -10...30)
    //            }
    //
    //            completion(results)
    //        }
    //    }
    
    func fetchWeatherHistory() async -> [Double] {
        print("1-1")
        let results = (1...100).map { _ in
            Double.random(in: -10...30)
        }
        return results
    }

    @available(*, deprecated, renamed: "calculateAverageTemperature()")
    func calculateAverageTemperature(for records: [Double], completion: @escaping (Double) -> Void) {
        // 对数组求和然后求平均值
        DispatchQueue.global().async {
            let total = records.reduce(0, +)
            let average = total / Double(records.count)
            completion(average)
        }
    }
    //
    func calculateAverageTemperature(for records: [Double] ) async -> Double {
        // 对数组求和然后求平均值
        let total = records.reduce(0, +)
        return total / Double(records.count)
    }
    
    
    //测试快捷键
    func calculateAverage(for records: [Double]) async -> Double {
        //        // 对数组求和然后求平均值
        if #available(iOS 13.0, *) {
            return await withCheckedContinuation { continuation in
                DispatchQueue.global().async {
                    let total = records.reduce(0, +)
                    let average = total / Double(records.count)
                    continuation.resume(returning: average)
                }
            }
        } else {
            // Fallback on earlier versions
            let total = records.reduce(0, +)
            return total / Double(records.count)
        }
    }
    
}

