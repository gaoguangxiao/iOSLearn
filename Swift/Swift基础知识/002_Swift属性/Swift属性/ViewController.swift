//
//  ViewController.swift
//  Swift属性
//
//  Created by 高广校 on 2023/11/15.
//

import UIKit

struct TwelveOrLess {
    private var number:Int
    
    init(number: Int) {
        self.number = number
    }
    
    var wrappedValue: Int {
        get {
            number
        }
        set {
            number = min(newValue, 12)
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var tew = TwelveOrLess(number: 40)
        print(tew.wrappedValue)
        
    }


}

