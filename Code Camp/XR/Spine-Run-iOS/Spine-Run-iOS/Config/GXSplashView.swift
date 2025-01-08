//
//  GXSplashView.swift
//  RSReading
//
//  Created by 高广校 on 2024/1/17.
//

import Foundation
import ZKBaseSwiftProject
import GGXOfflineWebCache
import RSBridgeOfflineWeb
import GGXSwiftExtension
import RxSwift
//import GXVersionUpdateView
import GXSwiftNetwork

class GXSplashView: ZKBaseView {
    var disposeBag = DisposeBag()
    
    var configFinishCompleted: ZKStringClosure? //web渲染完毕，关闭视图
    
    public var superVc: UIViewController?
    
    private let rate: CGFloat = ZKAdapt.rate
    
    var configIOSModel: RSConfigiOSModel?
    
    var webViewFinished: Bool = false
    var preProgressValue: Float = 0.0
    var preSpeedValue: String = "0KB"
    var progressValue: Float = 0.0 {
        didSet {
            self.customProgress.setProgress(progressValue, animated: false)
        }
    }
    
    //MARK: Lazy
    lazy var imageBackgroundView : UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: UIDevice.isIPad ? "launchbg" : "launchbg")
        return imageView
    }()
    
    lazy var imageIconView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: UIDevice.isIPad ? "launchloading" : "launchloading")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let lab = UILabel()
        //        textLabel.textColor = UIColor.init(hex: "41270E")
        lab.font = UIFont.systemFont(ofSize: UIDevice.isIPad ? 24*rate : 18*rate)
        return lab
    }()
    
    lazy var imageDisplayNameView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "lanchtrack_bg")
        return imageView
    }()
    
    lazy var customProgress : UIProgressView = {
        let progress = UIProgressView.init()
        progress.progress = 0.0
        progress.layer.masksToBounds = true
        
        progress.layer.cornerRadius = UIDevice.isIPad ? 13.0*rate : 9.0*rate
        progress.layer.borderWidth = UIDevice.isIPad ? 4.0*rate : 4.0*rate
        progress.layer.borderColor = UIColor.init(hex: "FFFFFF").cgColor
        progress.trackTintColor = UIColor.init(hex: "FFFFFF") //整体背景颜色
        progress.progressImage = UIImage.init(named: "lanchProgress_pad")
        return progress
    }()
    
    /// web解压类
    lazy var webOfflineUnzip: GXHybridZipManager = {
        let webOffline = GXHybridZipManager()
        webOffline.unzipDelegate = self
//        webOffline.webFolderName = "web/app"
        return webOffline
    }()
    
    /// web资源下载
    lazy var hybridPresetManager: GXHybridPresetManager = {
        let offline = GXHybridPresetManager()
        offline.delegate = self
        return offline
    }()
    
    public init(frame: CGRect,vc: UIViewController) {
        super.init(frame: frame)
        self.superVc = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    public override func setUpView() {
        buildUI()
        setupLayout()
        registerObsever()
        
        
        self.loadNetConfig()
        //        self.coverCompleted?(true)
    }
    
    public func hideCover() {
        //隐藏视图
        self.removeFromSuperview()
    }
    
    //MARK: Private
    private func buildUI(){
        
        addSubview(imageBackgroundView)
        addSubview(customProgress)
        addSubview(imageDisplayNameView)
        addSubview(textLabel)
        addSubview(imageIconView)
        
        if DevelopmentMode.isTest {
//            debugTest()
        }
    }
    
    private func  registerObsever() {
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: kWebviewEstimatedProgressValue))
            .subscribe(onNext: { [weak self] (value) in
                guard let `self` = self , !self.webViewFinished else {return}
                guard let valueObject = value.object as? NSNumber else {return}
                let progress = valueObject.floatValue
                if (progress == 1.0 ) {
                    delay(time: 0.25, task: {
                        self.customProgress.trackImage = nil
                    })
                    delay(time: 1, task: {
                        self.hideCover()
                    })
                }
                if (self.preProgressValue < progress){
                    self.customProgress.setProgress( progress , animated: true)
                    self.preProgressValue = progress
                    let value = Int(progress*100)
                    self.textLabel.text = "加载：\(value)%"
                }
            }).disposed(by: self.disposeBag)
        
//        NotificationCenter.default.rx.notification(Notification.Name(rawValue:  kWebReadyNoticefication))
//            .subscribe(onNext: { [weak self] (value) in
//                guard let `self` = self else {return}
//                self.webViewFinished = true
//                self.customProgress.setProgress( 1.0 , animated: true )
//                delay(time: 0.25 , task: {
//                    self.hideCover()
//                })
//            }).disposed(by: self.disposeBag)
    }
    
    
    
    private func setupLayout() {
        imageBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        customProgress.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIDevice.isIPad ? 615.0*rate : 435.0*rate)
            make.bottom.equalToSuperview().offset(UIDevice.isIPad ? -120.0*rate : -90.0*rate)
            make.height.equalTo(UIDevice.isIPad ? 26.0*rate : 18.0*rate)
        }
        
        imageDisplayNameView.snp.makeConstraints { (make) in
            make.edges.equalTo(customProgress)
            //            make.centerX.equalTo(view.snp.centerX)
        }
        
        imageIconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIDevice.isIPad ? 126.0*rate : 52.0*rate)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 500 * ZKAdapt.factor,
                                     height: 277 * ZKAdapt.factor))
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(customProgress.snp.bottom).offset(UIDevice.isIPad ? 15.0*rate : 15.0*rate)
        }
    }
    
    deinit {
        LogInfo("\(self)-deinit")
    }
}

//MARK: 离线包
extension GXSplashView {
    
    /// 加载配置
    func loadNetConfig() {
        
        ZKReachabilityManger.share.exeTaskOnceNetworkReachable {
            ConfigServiceManger.configServiceMangerRequest { (dataModel) in
                
                if let dataModel {
                    self.configIOSModel = dataModel
                    //版本
                    if let suv = self.superVc , let info = dataModel.iosVersion{
//                        GXVersionUpdateTool.handleVersionUpdate(infoMin: info.min, infoLatest: info.latest, infoTitle: info.title, infoReleaseNote: info.releaseNote, infoDownloadUrl: info.downloadUrl, vc: suv) { [weak self] b in
//                            guard let `self` = self else { return }
//                            ///为false代表无需更新 或者 下次
//                            if b == false {
                                self.finishVersion()
//                            }
//                        }
                    } else {
                        self.finishVersion()
                    }
                } else {
                    self.finishConfig()
                }
                
            }
        }
    }
    
    func finishVersion() {
        
        //解压预置离线资源
        webOfflineUnzip.unzipProjecToBox(zipName: "dist.zip") { isSuccess in
            
        }
    }
    
    func finishUnzip() {
        
        if let dataModel = self.configIOSModel {
            
//            //控制息屏策略
//            if let osWakeTime = dataModel.osWakeTime {
//                UserDefaults.idleOsWakeTime = osWakeTime
//            }
            
//            if appChannel == .online {
                //增加远端文件比对
                var urls: Array<String> = []
//                //下载预置离线包
//                if let initialMainFest = dataModel.manifest?.initialManifest {
//                    urls.append(initialMainFest)
//                }
                if let spineManifest = dataModel.manifest?.spineManifest {
                    urls.append(spineManifest)
                }
//                if let staticManifest = dataModel.manifest?.staticManifest {
//                    urls.append(staticManifest)
//                }
                
                self.hybridPresetManager.requestRemotePresetResources(jsonPath: urls)
//            } else {
//                self.finishConfig()
//            }
        } else {
            self.finishConfig()
        }
    }
    
    /// 离线包配置完毕
    func finishConfig()  {
        
        self.preProgressValue = 0.0
        self.customProgress.setProgress(0.0 , animated: false)
        
        self.textLabel.text = "加载：0%"
        
        self.configFinishCompleted?(self.configIOSModel?.manifest?.initialUrl ?? "")
        
        ///上报离线包数据
//        uploadAnalyWebInfo()
        
        //隐藏
        self.hideCover()
    }
    
}

extension GXSplashView {
    
    func uploadAnalyWebInfo() {
        var mainFestUrls: Dictionary<String,String> = [:]
        let hybridCache = GXHybridCacheManager()
        if let initialMainFest = self.configIOSModel?.manifest?.initialManifest,
           let initialMainFestPath = hybridCache.getOfflineManifestPathName(url: initialMainFest){
            mainFestUrls["Dmx_Key_OfflineInitial"] = initialMainFestPath.lastPathComponent
        }
        if let spineManifest = self.configIOSModel?.manifest?.spineManifest,
           let spineManifestPath = hybridCache.getOfflineManifestPathName(url: spineManifest){
            mainFestUrls["Dmx_Key_OfflineSpine"] = spineManifestPath.lastPathComponent
        }
        if let staticManifest = self.configIOSModel?.manifest?.staticManifest,
           let staticManifestPath = hybridCache.getOfflineManifestPathName(url: staticManifest){
            mainFestUrls["Dmx_Key_OfflineStatic"] = staticManifestPath.lastPathComponent
        }
        mainFestUrls["uuid"] = ZKUtils.deviceIdentifier
        PTDebugView.addLog("Dmx_OfflineWeb上报信息：\(mainFestUrls.toJsonString ?? "")")
//        UMAnalyticsSwift.event(eventId: "Dmx_OfflineWeb", attributes: mainFestUrls)
    }
}
