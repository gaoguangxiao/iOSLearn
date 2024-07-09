//
//  ViewController.swift
//  Swift的Async和Await
//
//  Created by 高广校 on 2023/11/15.
// https://juejin.cn/post/6844903937032601614
//https://www.jianshu.com/p/38d6ae5e2e78
import UIKit

extension UIImage {
    
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 40, height: 40)
            return await self.bycustomPreparingThumbnail(ofSize: size)
        }
    }
    
    func bycustomPreparingThumbnail(ofSize: CGSize) async -> UIImage? {
        if #available(iOS 150.0, *) {
            return self.preparingThumbnail(of: ofSize)
        } else {
            // 参数一：指定将来创建出来的图片大小
            // 参数二：设置是否透明
            // 参数三：是否缩放
            UIGraphicsBeginImageContextWithOptions(ofSize, false, 0)
            draw(in: CGRect(origin: CGPoint.zero, size: ofSize))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let outImg = image {
                return outImg
            } else {
                return self
            }
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var oImageView: UIImageView!
    @IBOutlet weak var tImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let originalImage = UIImage.launchbg
        print("originalImage: \(originalImage)")
        
        oImageView.image = originalImage
        
        Task {
            if let thumbnail = await originalImage.thumbnail {
                print("thumbnail: \(thumbnail)")
                tImageView.image = thumbnail
            } else {
                //缩略图失败
                print("thumbnail is nil")
            }
        }
        
        
        //        testAsync()
        
        /// 随机数据 和求取平均值
        //        testAsync2()
        
        
        testAsyn3()
        /**
         
         结构化并发：执行顺序是线性的
         */
        
    }
    
    //async和await函数
    func testAsync()  {
        
        print("步骤1-testAsync")
        
        //当试图从不支持并发的同步调用环境调用一个并发方法时，会出现`'async' call in a function that does not support concurrency`，如果将`testAsync`定义为异步，那么错误会转移到其他地方。可以使用`Task.init`方法
        //        let d = await fetchWeatherHistory()
        Task.init {
            //await：告诉程序等待返回结果，只有结果达到之后才能继续
            fetchWeatherHistory { d in
                print("步骤2：\(d)")
            }
            let d = await fetchWeatherHistory()
            print("步骤2 await：\(d)")
        }
        
    }
    
    /// 异步拉取10条随机数据，并求取平均值
    func testAsync2()  {
        Task {
            
            let d = await fetchWeatherHistory()
            print("步骤1: \(d)")
            //            calculateAverageTemperature(for: d) { d1 in
            //
            //            }
            let d1 = await calculateAverageTemperature(for: d)
            print("步骤2: \(d1)")
        }
    }
    
    /// 结构化并发异常抛出
    func testAsyn3() {
        
        //try：和do-catch一起使用，有异常处理异常
        
        //        try?、会将错误转化为可选值，不需要用 do-catch 包装，当使用，try? 调用函数时，如果函数抛出错误，会返回nil，否则为可选值
        //        Task {
        //            let f = try? await fetchThrowError(isNoThrows: false)
        //            print("f: \(String(describing: f))")// print f: nil
        //
        //            let f1 = try? await fetchThrowError(isNoThrows: true)
        //            print("f1: \(String(describing: f1))")// print Optional(10.0)
        //        }
        
        //try!：打破错误传播链条，当函数运行抛出错误时，程序就会崩溃
        Task {
            //            let f2 = try! await fetchThrowError(isNoThrows: false)
            //            print("f2: \(String(describing: f2))")// print f: nil
            
            let f3 = try! await fetchThrowError(isNoThrows: true)
            print("f3: \(String(describing: f3))")// print Optional(10.0)
        }
        
        //        Task {
        //            do {
        //                //try? try 的区别
        //                //try? 有黄色警告 不抛出错误
        //                //try 会进入错误
        //                let f = try? await fetchThrowError(isNoThrows: false)
        //                print("value: \(f)")
        //            } catch let e {
        //                print("thtow: \(e)")
        //            }
        //
        //        }
    }
    
    enum FetchError: Error {
        case customError
    }
    
    func fetchThrowError(isNoThrows: Bool) async throws -> Double {
        
        guard isNoThrows else {
            throw FetchError.customError
        }
        
        return 10
    }
    
    //Swift5.5之后代码改进
    func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
        // 省略复杂的网络代码，这里我们直接用100000条记录来代替
        print("1-1")
        DispatchQueue.global().async {
            let results = (1...10).map { _ in
                Double.random(in: -10...30)
            }
            
            completion(results)
        }
    }
    
    func fetchWeatherHistory() async -> [Double] {
        print("await 1-1")
        let results = (1...10).map { _ in
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
        print("await 2-1")
        let total = records.reduce(0, +)
        return total / Double(records.count)
    }
    
    
    //测试快捷键
    func calculateAverage(for records: [Double]) async -> Double {
        //        // 对数组求和然后求平均值
        if #available(iOS 13.0, *) {
            // 将block回调 转化为 async方法 `withCheckedContinuation`
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

