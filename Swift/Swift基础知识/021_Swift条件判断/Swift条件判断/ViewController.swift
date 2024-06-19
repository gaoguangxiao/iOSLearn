//
//  ViewController.swift
//  Swift条件判断
//
//  Created by 高广校 on 2023/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        Task {
            let clocl1 = ContinuousClock()
            try? await clocl1.sleep(for: .seconds(1))
            
        }
        
    }
    
    //Swift5.9新特性
    func testSwift5_9ifSwith() {
        let score = 85
        
        //       if
        
        //第一种写法
        var scoreStatus = ""
        
        //        if score > 60 {
        //            scoreStatus = "及格"
        //        } else {
        //            scoreStatus = "不及格"
        //        }
        
        //第二种
        //        let scoreStr = if score > 60 { "及格" } else { "不及格" }
        //        print(scoreStr)
        
        
        //        switch score {
        //        case 0..<60:
        //            scoreStatus = "不及格"
        //        case 60..<70:
        //            scoreStatus = "及格"
        //        default:
        //            scoreStatus = "优秀"
        //        }
        
//        let scoreStr = switch score {
//        case 0..<60 : "不及格"
//        case 60..<70: "及格"
//        default     : "优秀"
//        }
        
//        print(scoreStr)
    }
    
}

