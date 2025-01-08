//
//  RSSchemeHandlerWebVc.swift
//  RSBridgeOfflineWeb
//
//  Created by 高广校 on 2024/12/19.
//  具备bridge桥接和网络拦截功能

import UIKit
import RSBridgeCore

open class RSBridgeSchemeHandlerWebVc: RSBridgeWebViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    open override var schemeHandler: Any? {
        get {
            return RSURLSchemeHander()
        }
        set{}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
