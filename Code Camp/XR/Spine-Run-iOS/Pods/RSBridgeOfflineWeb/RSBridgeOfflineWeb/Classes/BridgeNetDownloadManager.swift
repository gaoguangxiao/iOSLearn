//
//  BridgeNetDownloadManager.swift
//  RSBridgeOfflineWeb
//
//  Created by 高广校 on 2024/12/24.
//

import Foundation
import GGXOfflineWebCache
import GXTaskDownload
import PTDebugView
import GGXSwiftExtension

public typealias RSTaskDownloadSpeedSizeBlock = (_ loaded: Double,
                                                 _ total: Double,
                                             _ loadedSize: Double,
                                             _ totalSize: Double,
                                              _ state: GXDownloadingState)->Void

public class BridgeNetDownloadManager {
    
    /// 总下载文件数
    var total: Double  = 0
    
    /// 已下载文件数
    var loaded: Double = 0
    
    /// 已下载大小
    var loadedSize: Double = 0
    
    ///. 总下载大小
    var totalSize: Double = 0
        
    lazy var webOfflineCache: GXHybridCacheManager = {
        let hybridCache = GXHybridCacheManager()
        return hybridCache
    }()
    
    lazy var oflineDownloadManager: GXDownloadManager = {
        let download = GXDownloadManager()
        download.isOpenDownloadSpeed = true
        return download
    }()
    
    func downloadAssets(jsonPath: String,
                        path: String = "pkg",
                        priority: Int,
                        configModel: GXWebOfflineManifestModel, block: @escaping RSTaskDownloadSpeedSizeBlock)  {
        
        let downloadUrls = configModel.getNoAlikeAssets(priority: priority)

        guard downloadUrls.count != 0 else {
            block(1,1,1,1,.error)
            return
        }
        
        ///读取jsonPath对应的本地匹配
        //        if let localJsonDict = self.webOfflineCache.getOldManifestData(url: jsonPath),
        //           let manifest = GXWebOfflineManifestModel.deserialize(from: localJsonDict) {
        //            if let deletes = manifest.assets?.filter({ !assets.contains($0)}) {
        //                self.webOfflineCache.removeOffline(assets: deletes)
        //            }
        //        }
        
        let downloadToPath = webOfflineCache.resourceCachePath + "/\(path)"

        oflineDownloadManager.start(forURL: downloadUrls,maxDownloadCount: 1, path: downloadToPath) { [weak self ]total, loaded, state in
            guard let self else {
                return
            }
            self.total = Double(total)
            self.loaded = Double(loaded)
            if state == .completed || state == .error {
                let pkgManifestPath = "/\(path)" + "/" + jsonPath.lastPathComponent
                self.webOfflineCache.updatePkgManifest(maniModel: configModel, maniPath: pkgManifestPath) { b in
                    block(Double(total),Double(loaded),self.loadedSize,self.totalSize,state)
                }
            } else {
                block(Double(total),Double(loaded),loadedSize,totalSize,state)
            }
        }

        oflineDownloadManager.downloadSpeedBlock = { [weak self] speed, loadedSize, totalSize in
            guard let self else { return }
            self.loadedSize = loadedSize
            self.totalSize = totalSize
            block(Double(total),Double(loaded),loadedSize,totalSize,.downloading)
        }
    }
        
    func getBoxPkgPath(url: String) -> String? {
        return GXHybridCacheManager.share.getOfflineLastPathComponent(url,extendPath: "/\(RSWebOfflineManager.share.webPkgName)")
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
    
    deinit {
        LogInfo("\(self)-deinit")
    }
}

//MARK: web资源下载方法
extension BridgeNetDownloadManager {
    
    /// 下载离线包
    func requestForLoadManifestAndResource(url: String, priority: Int = 3,block: @escaping RSTaskDownloadSpeedSizeBlock) {
        
        PTDebugView.addLog("loadPkg的URL: \(url)")
        
//        1、请求配置信息
        GXManifestApiService.requestManifestApi(url: url) { configModel in
            guard let configModel else {
                block(1,1,1,1,.error)
                return
            }
            //2、获取本地配置信息
            if let manimodel = self.getSandboxPkgModel(url: url), manimodel.versionSize >= configModel.versionSize {
                PTDebugView.addLog("\(manimodel.versionSize) == \(configModel.versionSize) 无需更新")
                block(1,1,1,1,.completed)
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
        
        GXManifestApiService.requestManifestApi(url: url) { configModel in
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
        GXManifestApiService.requestManifestApi(url: url) { configModel in
            
            if let configModel , let assets = configModel.assets {
                
                self.webOfflineCache.removeOffline(assets: assets, folder: RSWebOfflineManager.share.webPkgName)
                
                self.webOfflineCache.removeManifestFileByURL(remoteURL: url, extensionFolder: RSWebOfflineManager.share.webPkgName)
                //
                block(true)
            } else {
                
                block(false)
            }
        }
        
    }
    
    func removeAll() -> Bool {
        //清理缓存
        return webOfflineCache.removeFile(path: RSWebOfflineManager.share.webPkgName)
    }
    
    func removeAllOfline(path: String?) -> Bool {
        if let path {
            return webOfflineCache.removeFile(path: path)
        } else {
            //清理缓存
            return webOfflineCache.removeFile(path: "")
        }
    }
    
    
    @discardableResult
    func clearWebTemp() -> Bool{
        return self.removeAllOfline(path: RSWebOfflineManager.share.webTempName)
    }
}
