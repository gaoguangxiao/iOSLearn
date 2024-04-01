//
//  ViewController.swift
//  002_协议实用
//
//  Created by 高广校 on 2024/3/28.
//

import UIKit


//## 声明圆角协议
/// 声明一个圆角的能力协议
protocol RoundCornerable {
    func roundCorner(radius: CGFloat)
}

// 扩展圆角协议 但是必须是UIView的子类
extension RoundCornerable where Self: UIView {
    
    func roundCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

class shaLabel: UILabel, RoundCornerable {
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let l = shaLabel()
        
        l.roundCorner(radius: 9)
    }
}

