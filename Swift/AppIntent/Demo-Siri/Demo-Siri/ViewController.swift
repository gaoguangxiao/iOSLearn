//
//  ViewController.swift
//  Demo-Siri
//
//  Created by 高广校 on 2024/6/17.
//

import UIKit
import AppIntents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        GXOpenIntent()
        if #available(iOS 15.0, *) {
            view.backgroundColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
        
//        ShareViewController()
//        AppShortcut
//        AppShortcut(intent: <#T##AppIntent#>, phrases: <#T##[AppShortcutPhrase<AppIntent>]#>, shortTitle: <#T##LocalizedStringResource#>, systemImageName: <#T##String#>)
    }


}

