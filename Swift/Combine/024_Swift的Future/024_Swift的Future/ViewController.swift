//
//  ViewController.swift
//  024_Swift的Future
//
//  Created by 高广校 on 2023/12/27.
//

import UIKit
import Combine

class User {
    
}

class UserLoader {
    typealias Handler = (User) -> Void
    
//    func loadUser(withID id: Int, completionHandler: @escaping Handler) {
//       
//        let url = apiConfiguration.urlForLoadingUser(withID: id)
//
//        let c = URLSession(configuration: <#T##URLSessionConfiguration#>, delegate: <#T##URLSessionDelegate?#>, delegateQueue: <#T##OperationQueue?#>)
//        
//        let urlSession = URLSession(configuration: c)
//        
//        let task = urlSession.dataTask(with: url) { [weak self] data,, error in
//            if let error = error {
//                completionHandler(.error(error))
//            } else {
//                do {
//                    let user: User = try unbox(data: data ?? Data())
//
//                    self?.database.save(user) {
//                        completionHandler(.value(user))
//                    }
//                } catch {
//                    completionHandler(.error(error))
//                }
//            }
//        }
//
//        task.resume()
//    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Future&Promise 来源于函数式语言，概念早在 1977 年就已经提出来了。其目的是分离一个值和产生值的方法，从而简化异步代码的处理。
//        Future 是一个只读的值的容器，它的值在未来某个时刻会被计算出来（产生这个值的行为是异步操作）。
//        Promise 是一个可写的容器，可以设置 Future 的值。

//        Future
    }


}

