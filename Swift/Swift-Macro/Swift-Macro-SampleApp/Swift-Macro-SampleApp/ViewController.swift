//
//  ViewController.swift
//  Swift-Macro-SampleApp
//
//  Created by 高广校 on 2024/6/20.
//

import UIKit
#if canImport(WWDC2023)
import WWDC2023
#endif

#if canImport(WWDCSlope)
import WWDCSlope
#endif
 
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        invokeExpandUnit()
        invokeSlope()
    }
    
    func invokeSlope()  {
        //        let easyBeginers = EasySlope.beginnersParadise
        //        print("easyBeginers: \(easyBeginers)")
#if canImport(WWDCSlope)
        if let easy = EasySlope(.beginnersParadise) {
            print("easy: \(easy)")
        }
#else
        print("can't import WWDCSlope")
#endif
    }
    
    func invokeExpandUnit() {
#if canImport(WWDC2023)
        let a = 17
        let b = 25
        //宏的调用
        //宏展开，右键 Expand Macro
        //        let (result, code) = #stringify(a + b)
        //        print("The value \(result) was produced by the code \"\(code)\"")
#else
        print("can't import WWDC2023")
#endif
    }
    
}

