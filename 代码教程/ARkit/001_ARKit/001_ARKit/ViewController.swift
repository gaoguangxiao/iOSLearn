//
//  ViewController.swift
//  001_ARKit
//
//  Created by 高广校 on 2023/12/20.
//

import UIKit
import ARKit
//import SensorKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ARKit只负责捕捉平地事件，实现ARSCNViewDelegate监听捕捉平地回调
        
        self.view.addSubview(self.arSCNView)
        
        self.arSession.run(self.arSessionConfiguration)
        
    }

    
    
    lazy var arSessionConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        configuration.isLightEstimationEnabled = true
        return configuration
    }()
    
    //加载拍摄会话
    lazy var arSession: ARSession = {
        let session = ARSession()
        session.delegate = self
        return session
    }()
    
    //展示AR界面
    lazy var arSCNView: ARSCNView = {
        let view = ARSCNView(frame: self.view.bounds)
        view.delegate = self
        view.session  = self.arSession//设置视图会话
        return view
    }()

}


extension ViewController: ARSCNViewDelegate {
    
}

extension ViewController: ARSessionDelegate {
    
}
