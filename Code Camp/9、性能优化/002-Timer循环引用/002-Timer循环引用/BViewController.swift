//
//  BViewController.swift
//  002-Timer循环引用
//
//  Created by 高广校 on 2023/12/21.
//  处理这种界面销毁

import UIKit

class BViewController: UIViewController {

    var lineTimer :Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        initTimer()
        //循环引用的问题是，控制器引用timer，解决方案，建立一个继承自proxy的中间类
//        initScheduleTimer()
//        initProxyTimer()
//        self.initBlockTimer()
        initextensionTimer()
    }
    
    func initTimer() {
        /**
         init(timeInterval...) 创建的timer需要添加runloop中
         */
        lineTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateLineTime), userInfo: nil, repeats: true)
        if let lineTimer = lineTimer {
//           由于主线程中的RunLoop是常驻内存同时对Timer的强引用，Timer是局部变量依然会产生循环引用问题
//           Timer继续对控制器强引用
            RunLoop.current.add(lineTimer, forMode: .common)
        }
        
    }
    
    func initScheduleTimer() {
        //已经添加到runloop中，但仍旧有循环引用问题
        let lineTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLineTime), userInfo: nil, repeats: true)

    }
    
    func initProxyTimer() {
        let pro = SwiftWeakProxy(self)
        lineTimer = Timer.scheduledTimer(timeInterval: 1.0, target: pro, selector: #selector(updateLineTime), userInfo: nil, repeats: true)
    }
    
    func initBlockTimer() {
    
        lineTimer = Timer.init(timeInterval: 1.0, repeats: true, block: { [weak self]  timer in
            guard let `self` = self else { return }
            self.updateLineTime()
        })
        if let lineTimer = lineTimer {
            RunLoop.current.add(lineTimer, forMode: .common)
        }
    }
    
    func initextensionTimer()  {
        lineTimer = Timer.zk_scheduledTimer(timeInterval: 1.0, repeats: true, with: { [weak self]  in
            guard let `self` = self else { return }
            self.updateLineTime()
        })
    }
    
    @objc func updateLineTime()  {
        print("定时器--调用")
        
        let timerInterval = lineTimer?.timeInterval
        print("lineTimer?.timeInterval:\(timerInterval)")
//        lineTimer?.timeInterval
    }
    
    deinit {
        lineTimer?.invalidate()//
        print("\(self)-deinit")
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
