//
//  ViewController.swift
//  Xcode-log
//
//  Created by 高广校 on 2024/2/18.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let logger = Logger(subsystem: "app.learn.subsystem", category: "app.learn.category")
//        logger.debug(<#T##message: OSLogMessage##OSLogMessage#>)
        logger.debug("this is debug logger")
        logger.info("this is info logger")
        logger.error("this is error logger")
        logger.log("this is log logger")
        logger.warning("This a warning logger")
        
        let logdefault = Logger()
        logdefault.debug("This is a default debug logger")
        
//        logdefault.warning("This a warning logger")
        //`OSLog`是
        
        // 默认os_log
        os_log("This is a log message.")
        
        // 自定义级别输出 type
        os_log("This is a addtional info that may be helpful for", log: .default,type: .error)
        
        /// 自定义子系统 级别
        let defaultOSLog = OSLog(subsystem: "osloglearn.subsystem", category: "osloglearn.category")
        os_log("This is info that may be helpful during development or debugging", log: defaultOSLog,type: .debug)        
    }


}

