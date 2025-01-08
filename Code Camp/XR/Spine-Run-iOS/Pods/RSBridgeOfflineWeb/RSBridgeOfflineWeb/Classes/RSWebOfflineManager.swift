//
//  RSWebOfflineManager.swift
//  RSBridgeOfflineWeb
//
//  Created by 高广校 on 2024/1/4.
//  离线包管理-1、离线包更新，2、判断缓存策略，返回对应数据

import Foundation
import GGXOfflineWebCache
import GXTaskDownload
import ZKBaseSwiftProject
import GGXSwiftExtension

//更新配置数据
public class RSWebOfflineManager: NSObject {
    
    public static let share = RSWebOfflineManager()
    
    //离线包开关
    public var enable_cache = false
    
    /// 获取配置数据
    public var contentManifest: String?

    /// 离线包管理类
    lazy var webOfflineCache: GXHybridCacheManager = {
        let hybridCache = GXHybridCacheManager()
        return hybridCache
    }()
    
    /// 离线下载
    lazy var oflineDownload: GXHybridDownload = {
        let download = GXHybridDownload()
        download.hyDownPath = "WebResource"
        return download
    }()
    
    //MARK: 根据JSON配置获取数据
    func requestInfoForManifestAPI(jsonPath url: String, block: @escaping (GXWebOfflineManifestModel?) -> Void) {
        GXManifestApiService.requestManifestApi(url: url, closure: block)
    }
    
    deinit {
        LogInfo("\(self)-deinit")
    }
}

//MARK: 动态资源
extension RSWebOfflineManager {
    
    /// loadpkg目录/pkg/
    var webPkgName: String {
        return "pkg"
    }
    
    func getBoxPkgPath(url: String) -> String? {
        return GXHybridCacheManager.share.getOfflineLastPathComponent(url,extendPath: "/\(self.webPkgName)")
    }
    /// 通过URL的json获取离线包ManifestModel-本地资源目录
    /// - Parameter url: url description
    /// - Returns: <#description#>
    func getSandboxPkgModel(url: String) -> GXWebOfflineManifestModel? {
        if let boxConfigPath = getBoxPkgPath(url: url) ,
           let localPresetConfigData = boxConfigPath.toFileUrl?.filejsonData{
            guard let localJsonDict = localPresetConfigData as? Dictionary<String, Any> else {
                print("JSON格式有问题")
                return nil
            }
            let baseModel = GXWebOfflineManifestModel.deserialize(from: localJsonDict)
            return baseModel
        }
        return nil
    }
    
}

// MARK: 临时资源
public extension RSWebOfflineManager {
    
    var webTempName: String {
        return "webTemp"
    }
    
    @discardableResult
    func clearWebTemp() -> Bool{
        return self.removeAllOfline(path: webTempName)
    }
}

//MARK: web资源下载方法
extension RSWebOfflineManager {
    
    func downloadAssets(jsonPath: String,
                        path: String = "pkg",
                        priority: Int,
                        configModel: GXWebOfflineManifestModel, block: @escaping GXTaskDownloadTotalBlock)  {
        
        guard let assets = configModel.assets else {
            block(1.0,1.0,.error)
            return
        }
        
        guard assets.count != 0 else {
            block(1.0,1.0,.error)
            return
        }
        
        ///读取jsonPath对应的本地匹配
        //        if let localJsonDict = self.webOfflineCache.getOldManifestData(url: jsonPath),
        //           let manifest = GXWebOfflineManifestModel.deserialize(from: localJsonDict) {
        //            if let deletes = manifest.assets?.filter({ !assets.contains($0)}) {
        //                self.webOfflineCache.removeOffline(assets: deletes)
        //            }
        //        }
        
        
        oflineDownload.download(urls: assets, path: path, priority: priority) { [weak self ]total, loaded, state in
            guard let `self` = self else {return}
            if state == .completed || state == .error {
                let pkgManifestPath = "/\(self.webPkgName)" + "/" + jsonPath.lastPathComponent
                self.webOfflineCache.updatePkgManifest(maniModel: configModel, maniPath: pkgManifestPath) { b in
                    block(total,loaded,state)
                }
            } else {
                block(total,loaded,state)
            }
        }
    }
}


//MARK: 离线包JSbridge交互
public extension RSWebOfflineManager {
    
    /// 下载离线包
    func requestForLoadManifestAndResource(url: String, priority: Int = 3,block: @escaping GXTaskDownloadTotalBlock) {
        
        PTDebugView.addLog("loadPkg的URL: \(url)")
        /// 1、请求配置信息
        self.requestInfoForManifestAPI(jsonPath: url) { configModel in
            
            guard let configModel else {
                block(1,1,.error)
                return
            }
            //2、获取本地配置信息
            if let manimodel = self.getSandboxPkgModel(url: url), manimodel.versionSize >= configModel.versionSize {
                PTDebugView.addLog("\(manimodel.versionSize) == \(configModel.versionSize) 无需更新")
                block(1,1,.completed)
                return
            }
            //下载
            self.downloadAssets(jsonPath: url, priority: priority,configModel: configModel, block: block)
            
        }
    }
    
    //
    func checkIfManifestExsit(url: String, resManifestName: String, block: @escaping (Int)->Void) {
        // 离线包可用为0，未下载或需更新非0
        //       * 0：已下载，且为最新
        //       * 1：未下载
        //       * 2：需更新
        PTDebugView.addLog(url)
        ///2、获取配置信息
        guard let manimodel = getSandboxPkgModel(url: url) else {
            block(1)
            return
        }
        self.requestInfoForManifestAPI(jsonPath: url) { configModel in
            //            print("当前json资源版本：\(manimodel.version ?? "")")
            if let configModel {
                if manimodel.versionSize < configModel.versionSize {
                    block(2)
                } else {
                    block(0)
                }
            } else {
                //远程没有配置文件
                block(404)
            }
        }
    }
    
    /// 删除指定的pkg文件
    /// - Parameter url: <#url description#>
    /// - Returns: <#description#>
    func removePkg(url: String, block: @escaping (Bool)->Void ) {
        
        /// 请求配置信息
        self.requestInfoForManifestAPI(jsonPath: url) { configModel in
            
            if let configModel , let assets = configModel.assets {
                
                self.webOfflineCache.removeOffline(assets: assets, folder: self.webPkgName)
                
                self.webOfflineCache.removeManifestFileByURL(remoteURL: url, extensionFolder: self.webPkgName)
                //
                block(true)
            } else {
                
                block(false)
            }
        }
        
    }
    
    func removeAll() -> Bool {
        //清理缓存
        return webOfflineCache.removeFile(path: webPkgName)
        //        return webOfflineCache.removeAll()
    }
    
    func removeAllOfline(path: String?) -> Bool {
        if let path {
            return webOfflineCache.removeFile(path: path)
        } else {
            //清理缓存
            return webOfflineCache.removeFile(path: "")
        }
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
