//
//  CViewController.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2023/12/21.
//

import UIKit

class CViewController: UIViewController {

    var ClineTimer :Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        ClineTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        
        
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
