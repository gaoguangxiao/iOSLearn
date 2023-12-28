//
//  ViewController.swift
//  021_Swift的Combine
//
//  Created by 高广校 on 2023/12/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        var observable = AnyObservable<AnyObserver<String>>("hello")
//        let observer = AnyObserver<String>(name: "My Observer")
//        observable.attach(observer: observer)
//        observable.state = "world"
        
        //Combine
        let stringPublisher = Just("Hello")// "Hello"
        let uppercasedPublisher = stringPublisher.map { char in
            char.uppercased()
        }
        
//        uppercasedPublisher.output
//        print("uppercasedPublisher:\(uppercasedPublisher)")
//        
//        //过滤偶数
//        let arrayPublisher = [1, 2, 4, 5].publisher
//        let oddPublisher = arrayPublisher.filter { $0 % 2 != 0 }
//        print("oddPublisher:\(oddPublisher)")
//        
        //数组中的值乘以2
//        let publisher = [1, 2, 3].publisher
//        let newPub = publisher.map { $0 * 2 }
        
//        print(newPub)
//
        
        //发布者，publisher
//        订阅者：subscriber
//        操作符:operator
        
//        let timer = Timer.publish(every: 1, on: .main, in: .default)
//        let temp = check("Timer") {timer
//            print("打印")
//        }
//        timer.connect()
        
    }


}

