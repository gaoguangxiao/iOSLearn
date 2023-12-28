//
//  ViewController.swift
//  022_Swift_Combine样例
//
//  Created by 高广校 on 2023/12/27.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Assign可以很方便将接收到的值通过keypath设置到指定的Class
        //创建一个订阅者，将文本输入框的文本内容赋值给textField对象的text属性，
        let subscriber = Subscribers.Assign(object: self.textField, keyPath: \.text)

//      然后订阅textField的editingChanged事件
        self.textField.publisher(for: )
                    .map { $0.text ?? "" }
                    .subscribe(subscriber)
                    .store(in: &cancellables)
     //        self.textField.publisher(for: .e)
    }


}

