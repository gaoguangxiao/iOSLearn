//
//  ViewController.swift
//  025_Swift的Future
//
//  Created by 高广校 on 2023/12/28.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var cancellables = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        Future&Promise 来源于函数式语言，概念早在 1977 年就已经提出来了。其目的是分离一个值和产生值的方法，从而简化异步代码的处理。
        //        Future 是一个只读的值的容器，它的值在未来某个时刻会被计算出来（产生这个值的行为是异步操作）。
        //        Promise 是一个可写的容器，可以设置 Future 的值。
        
        //创建一个发布者
//        let publisher = Future<String, Error>{ promise in
//            // 发送了第一条消息
//            promise(.success("同志们好！"))
//            // 发送了第二条消息（由于该发布者只能发送一次消息，所以这个消息不会有人收到）
//            promise(.success("同志们辛苦了！"))
//        }
        

        // 第一个订阅者订阅了消息
//        publisher.sink { state in
//            switch state {
//            case .finished:
//                print("完成1")
//            case .failure(_):
//                print("失败1")
//            }
//        } receiveValue: { msg in
//            print("receive1: \(msg)")
//        }
//        .store(in: &cancellables)

        self.request(url: "h")
            .sink { state in
                switch state {
            case .finished:
                print("完成1")
            case .failure(_):
                print("失败1")
            }
        } receiveValue: { msg in
            print("receive1: \(msg)")
        }
        .store(in: &cancellables)
        
//        self.request(url: "").receive(on: <#T##Scheduler#>)

    }
    
    func request(url: String) -> Future<String,Error> {
        return Future<String, Error>{ promise in
//            promise(.success("获取到Data数据"))
            promise(.failure(cError.er))
        }
    }
}

enum cError: Error {
    case er
}
