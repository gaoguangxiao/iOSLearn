//
//  ViewController.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2023/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func 打开定时器界面(_ sender: Any) {
        
        let Vc = BViewController()

        self.navigationController?.pushViewController(Vc, animated: true)
//        self.present(Vc, animated: true)
    }
}

