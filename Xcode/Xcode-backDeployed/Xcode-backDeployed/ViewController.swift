//
//  ViewController.swift
//  Xcode-backDeployed
//
//  Created by 高广校 on 2024/6/25.
//

import UIKit

@available(iOS 15.0, *)
public struct Temperature {
    /// 摄氏度
    public var degreesCelsius: Double
}


//only available in iOS 17.0 or newer
//extension Temperature {
//    /// 华氏温度
//    @available(iOS 17, *)
//    public var degreesFahrenheit: Double {
//        return (degreesCelsius * 9 / 5) + 32
//    }
//}

// 上面有错误提示，用到@backDeployed
extension Temperature {
    /// 华氏温度
    @available(iOS 15.0, *)
    @backDeployed(before: iOS 17)
    public var degreesFahrenheit: Double {
        return (degreesCelsius * 9 / 5) + 32
    }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        
        //  if #available(iOS 15.0, *) {
        let temp = Temperature(degreesCelsius: 10)
        print("temp: \(temp.degreesCelsius)")
        
        // 使此属性 让旧系统也能使用。iOS17之后增加的属性
//        if #available(iOS 17, *) {
            print("temp new version: \(temp.degreesFahrenheit)")
//        } else {
            // Fallback on earlier versions
//        }
}
    
    
}

