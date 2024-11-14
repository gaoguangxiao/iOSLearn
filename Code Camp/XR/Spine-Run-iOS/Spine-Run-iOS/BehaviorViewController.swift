//
//  BehaviorViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/14.
//

import UIKit

class BehaviorViewController: UIViewController, DisplayTimerProtocal {
    
    var display: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func startTimer() {
        display = CADisplayLink(target: self, selector: #selector(updateObjc))
    }
    
    func stopTimer() {
        display = nil
    }
    
    @objc func updateObjc(){
        update()
    }
    
    func update() {
        
        print("QQQQ")
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

protocol DisplayTimerProtocal {
    
    func update()
    
}

extension DisplayTimerProtocal {
    func initTimer() {
        
        
    }
    
    
}
