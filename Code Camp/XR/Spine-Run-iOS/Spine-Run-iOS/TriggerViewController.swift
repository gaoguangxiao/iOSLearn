//
//  TriggerViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/26.
//

import UIKit
import GGXSwiftExtension
import ZKBaseSwiftProject
import GGXOfflineWebCache

class TriggerViewController: BehaviorViewController {
    
    lazy var skeletonScript: SkeletonAnimationScript = {
        let script = SkeletonAnimationScript()
//        script.isDebugPolygons = true
        script.delegate = self
        return script
    }()
    
    
    let source = SkeletonSource()
    
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .pickAllBg)
//        imageView.contentMode = .scaleAspectF
        return imageView
    }()
    
    lazy var stonebgImage: UIImageView = {
        let imageView = UIImageView(image: .item)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //放置石头
    lazy var stoneImage: UIImageView = {
        let imageView = UIImageView(image: .fish)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var pausebtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .purple
        btn.setTitle("暂停", for: .normal)
        btn.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initBgV2()
        
        let datumboy = Datum.babuV13Offline()
        
        source.loadStonesImages()
        
        Task {
//            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(20, 290 * ZKAdapt.factor, 200, 120),datum: datumboy)
            
            if let atlas = datumboy.atlas, let json = datumboy.json {
                if let atlasURL = GXHybridCacheManager.share.loadOfflinePath(atlas),
                   let jsonURL = GXHybridCacheManager.share.loadOfflinePath(json)
                {
                    try? await skeletonScript.setSkeletonFromFile(atlasPath: atlasURL, jsonPath: jsonURL)
                }
            }
            
            guard let spineView = skeletonScript.spineUIView  else {
                print("spineUIView is nil")
                return
            }
            view.addSubview(spineView)

        }
    }
    
    //获取点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取spine点击点
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        guard isRuning else {
            return
        }
        if let touch = touches.first {
            let distance = touch.location(in: view) - spineUIView.center
            skeletonScript.runToDistance(distance: distance)
        }
    }
    
    //障碍物移动速度
    var stoneSpeed: Float = 2.0
    // 游戏状态
    var isRuning = true
    
    override func update() {
        
        guard isRuning else {
            return
        }
        stonebgImage.translate(CGPoint(x: 0, y: Int(1.0 * stoneSpeed)))
        if stonebgImage.bottom >= UIDevice.heightf - 20 {
            resetStone()
        }
    }
    
    //重置坐标
    func resetStone() {
        stonebgImage.y = -50
        stonebgImage.x = CGFloat(Float.random(in: 50..<Float(UIDevice.widthf) - 100))
        stoneImage.image = source.medals?.randomElement()
    }
}

//MARK: - 视图
extension TriggerViewController {
    func initBgV2() {
        view.addSubview(imageBgView)
        imageBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        
        view.addSubview(stonebgImage)
        stonebgImage.frame = CGRect(x: view.centerX, y: 0, width: 50, height: 50)

        stonebgImage.addSubview(stoneImage)
        stoneImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        view.addSubview(pausebtn)
        pausebtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
}

//MARK: - SkeletonGraphicDelegate
extension TriggerViewController: SkeletonGraphicDelegate {
    func onUpdatePolygonsTransforms(skeletonGraphicScript: SkeletonGraphicScript) {
        
    }
    
    func onAfterUpdateWorldTransforms(skeletonGraphicScript: SkeletonGraphicScript) {
        
    }
    
    func onInitialized(skeletonGraphicScript: SkeletonGraphicScript) {
        //spine初始化完毕，渲染触发点
//        debugSlotPathPoint()
    }
    
    //
    func onTriggerEnter(other: UIView) {
        if other == stonebgImage {
            resetStone()
            
            //1.5秒之后
            isRuning = false
            
//            skeletonScript.setAnimationName(animationName: CharaterBodyState.naotou.rawValue) { type, entry, event in
//                print("naotou animation event：\(String(describing: event)) type：\(type.SIEventType.rawValue)");
//                if type.SIEventType == .END ||
//                    type.SIEventType == .COMPLETE{
//                    self.isRuning = true
//                    //之前新轨道1 应该清理掉
//                    self.skeletonScript.setAnimationName(animationName: CharaterBodyState.animation.rawValue)
//                }
//            }
            //
            skeletonScript.addAnimationName(trackIndex: 1,animationName: CharaterBodyState.naotou.rawValue) { [self] type, entry, event in
                print("naotou animation event：\(String(describing: event)) type：\(type.SIEventType.rawValue)");
                if type.SIEventType == .COMPLETE {
                    self.isRuning = true
                    
                    //清理挠头的动画
                    skeletonScript.clearTrack(trackIndex: 1)
                    
                    //之前新轨道1 应该清理掉
                    self.skeletonScript.setAnimationName(animationName: CharaterBodyState.animation.rawValue)
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
//                self.isRuning = true
//                
//                self.skeletonScript.playAnimationName(trackIndex: 0,animationName: CharaterBodyState.animation.rawValue)
            }
        }
    }
}

//MARK: 交互
extension TriggerViewController {
    
    @objc func pauseGame(){
        isRuning.toggle()
        pausebtn.setTitle(!isRuning ? "继续" : "暂停", for: .normal)
    }
}

@available(iOS 17.0,*)
#Preview(body: {
    TriggerViewController()
})
