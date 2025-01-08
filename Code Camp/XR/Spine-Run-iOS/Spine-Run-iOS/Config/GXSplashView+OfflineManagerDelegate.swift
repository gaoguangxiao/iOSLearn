//
//  GXSplashView+OfflineManagerDelegate.swift
//  RSReading
//
//  Created by 高广校 on 2024/1/9.
//

import Foundation
import GGXSwiftExtension
import GGXOfflineWebCache
import RSBridgeOfflineWeb

let downloadTipsText = "课程更新资源下载中"

//MARK: GXHybridPresetManagerDelegate
extension GXSplashView: GXHybridPresetManagerDelegate {
    func offlineWebSpeed(speed: Double, loaded: Double, total: Double) {
        
    }
    
    //开始请求下载文件
    func offlineWebComparison() {
        //开始对比文件
        self.preProgressValue = 0.0
        self.customProgress.setProgress(0.0 , animated: false)
        self.textLabel.text = "请求：0%"
    }
    
    //显示每秒多少MB，不足1MB时候显示KB。下载进度+速度
    func offlineWebProgress(progress: Float) {
        DispatchQueue.main.async {
            if (self.preProgressValue < progress){
                self.customProgress.setProgress( progress , animated: true)
                self.preProgressValue = progress
                let value = progress*100
//                self.textLabel.text = "请不要关闭此界面或者退出app，下载：\(value)%"
                self.textLabel.text = "\(downloadTipsText)：\(String(format: "%.2f", value))%，每秒\(self.preSpeedValue)"
            }
        }
    }

    func offlineWebSpeed(speed: Double) {
        let value = speed.toDiskSize()
        self.preSpeedValue = value
        let proValue = self.preProgressValue*100
        DispatchQueue.main.async {
            self.textLabel.text = "\(downloadTipsText)：\(String(format: "%.2f", proValue))%，每秒\(value)"
        }
    }
    
    func offlineWeb(completedWithError error: Error?) {
        LogInfo("离线包加载完毕")
        DispatchQueue.main.async {
            self.preProgressValue = 1.0
            self.textLabel.text = "\(100)%"
            self.customProgress.setProgress(1.0 , animated: true)
            
            self.finishConfig()
        }
    }
}

//MARK: GXHybridZipManagerDelegate
extension GXSplashView: GXHybridZipManagerDelegate {
    
    func offlineUnZipipWebProgress(progress: Float) {
//        print("离线包解压进度：\(progress)-/\(Thread.current)")
        if (self.preProgressValue < progress){
            self.customProgress.setProgress( progress , animated: true)
            self.preProgressValue = progress
            let value = Int(progress*100)
            self.textLabel.text = "解压：\(value)%"
        }
    }
    
    func configWebStart() {
        self.preProgressValue = 0.0
        self.customProgress.setProgress(0.0 , animated: false)
    }
    
    func offlineConfigWebProgress(progress: Float) {
        if (self.preProgressValue < progress){
            self.customProgress.setProgress( progress , animated: true)
            self.preProgressValue = progress
            let value = Int(progress*100)
            self.textLabel.text = "配置：\(value)%"
        }
    }
    
    func offlineUnzip(completedWithError: Bool) {
        //解压完毕
        self.finishUnzip()
    }
}
