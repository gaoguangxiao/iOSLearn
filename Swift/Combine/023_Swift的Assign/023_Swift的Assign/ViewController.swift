//
//  ViewController.swift
//  023_Swift的Assign
//
//  Created by 高广校 on 2023/12/27.
//

import UIKit
import Combine

class Student {
    var name: String?
    var score: Int
    
    init(name: String? = nil, score: Int) {
        self.name = name
        self.score = score
    }
}

extension Notification.Name{
    static var newTrickDownloaded:Notification.Name {
        return Notification.Name("aa")
    }
}

extension Publishers {
//    final public class Future<Output, Failure> : Publisher where Failure : Error {
//        public typealias Promise = (Result<Output, Failure>) -> Void
//        public init(_ attemptToFulfill: @escaping (@escaping Publishers.Future<Output, Failure>.Promise) -> Void)
//        final public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber
//    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let student = Student(name: "Jack", score: 90)
        print(student.score)
        
        //Assign可以很方便将接收到的值通过keypath设置到指定的Class
        let observer = Subscribers.Assign(object: student, keyPath: \.score)
        
        //PassthroughSubject 为内置的一个Publisher
        let publisher = PassthroughSubject<Int, Never>()
        
        publisher.subscribe(observer)
        publisher.send(91)
        
        print(student.score)
        
//        observer.cancel()
        
        publisher.send(100)
        print(student.score)
        
        
//        let trickNamePublisher = NotificationCenter.Publisher(center: .default, name: .newTrickDownloaded)
//            .map{ notification -> Data in
//                let userInfo = notification.userInfo
//                return userInfo?["data"] as! Data
//            }
//            .flatMap{ data in
//                
//                return Publishers.Future { promise in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        promise(.success(data))
//                    }
//                }
//            }
    }

//    func asyncFunction(callback:(Result<Any, <#Failure: Error#>>) -> Void) -> Void {
//        dispatch_async(queue) {
//            let x = Result("Hello!")
//            callback(x)
//        }
//    }

}

