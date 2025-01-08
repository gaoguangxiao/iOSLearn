//
//  RSWebOfflineManager.swift
//  RSBridgeOfflineWeb
//
//  Created by 高广校 on 2024/1/4.
//  离线包管理 缓存外界属性值

import Foundation
import GGXOfflineWebCache
import GXTaskDownload
import ZKBaseSwiftProject
import GGXSwiftExtension
import PTDebugView

//更新配置数据
public class RSWebOfflineManager: NSObject {
    
    public static let share = RSWebOfflineManager()
    
    //离线包开关
    public var enable_cache = false
    
    /// pkg配置的URL
    public var contentManifest: String?

    // 动态
    public var webPkgName = "pkg"
     
    // 临时资源存储文件夹
    public var webTempName = "webTemp"
    
    let bridgeNetDownloadManager = BridgeNetDownloadManager()
    
    /// 清理临时缓存资源
    public func clearWebTemp() -> Bool{
        bridgeNetDownloadManager.removeAllOfline(path: webTempName)
    }
    
    /// 清理所有离线资源
    public func removeAllOfline(path: String?) -> Bool {
        bridgeNetDownloadManager.removeAllOfline(path: path)
    }
    
    deinit {
        LogInfo("\(self)-deinit")
    }
}

//MARK: URL转换
public extension RSWebOfflineManager {
    
    /// 请求离线数据的本地URL路径
    /// - Parameter url: <#url description#>
    /// - Returns: <#description#>
    func requestOfflinePathWith(url: String) -> String? {
        //读取临时目录
        if let filePath = GXHybridCacheManager.share.loadTempOfflinePath(url, extensionFolder: self.webTempName){
            PTDebugView.addLog("离线策略：\(url)")
            return filePath
        }
        guard self.enable_cache == true else {
            GXHybridCacheManager.share.asyncDownloadfflineWithURL(forURL: url, extensionFolder: webTempName)
            PTDebugView.addLog("网络策略：\(url)")
            return nil
        }
        if let filePath = GXHybridCacheManager.share.loadOfflinePath(url, extensionFolder: self.webPkgName){
            PTDebugView.addLog("离线策略：\(url)")
            return filePath
        }
        PTDebugView.addLog("网络策略：\(url)")
        GXHybridCacheManager.share.asyncDownloadfflineWithURL(forURL: url, extensionFolder: webTempName)
        return nil
    }
    
    /// 请求离线包数据
    /// - Parameter url: <#url description#>
    /// - Returns: <#description#>
    func requestOfflineDataWith(url: String) -> Data? {
        if let filePath = GXHybridCacheManager.share.loadTempOfflineData(url, extensionFolder: self.webTempName){
            PTDebugView.addLog("离线策略：\(url)")
            return filePath
        }
        guard self.enable_cache == true else {
            GXHybridCacheManager.share.asyncDownloadfflineWithURL(forURL: url, extensionFolder: webTempName)
            PTDebugView.addLog("网络策略：\(url)")
            return nil
        }
        if let fileData = GXHybridCacheManager.share.loadOfflineData(url,extensionFolder: self.webPkgName){
            PTDebugView.addLog("离线策略：\(url)")
            return fileData
        }
        //本地没有此文件，需要下载至缓存目录
        PTDebugView.addLog("网络策略：\(url)")
        GXHybridCacheManager.share.asyncDownloadfflineWithURL(forURL: url, extensionFolder: webTempName)
        return nil
    }
}
