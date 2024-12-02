//
//  RunViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/28.
//

import UIKit
import ZKBaseSwiftProject
import GGXSwiftExtension

class RunViewController: BehaviorViewController {
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .a5922Dbfe3F7B5F4Cca6B3Cd83497106)
        imageView.isUserInteractionEnabled = true
        imageView.tag = 1
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var imageBgView2: UIImageView = {
        let imageView = UIImageView(image: .a5922Dbfe3F7B5F4Cca6B3Cd83497106)
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .white
        imageView.tag = 1
        return imageView
    }()
    
    lazy var imageBgView3: UIImageView = {
        let imageView = UIImageView(image: .a5922Dbfe3F7B5F4Cca6B3Cd83497106)
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .white
        imageView.tag = 1
        return imageView
    }()
    //背景图片 至少三张，否则第一张切换时，容易漏出背景
    var imageBgViews: [UIImageView] = []
    
    lazy var pausebtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .purple
        btn.setTitle("暂停", for: .normal)
        btn.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        return btn
    }()
    
    let skeletonScript = SkeletonAnimationScript()
    let source = SkeletonSource()
    //移动速度
    var moveSpeed: CGFloat = 4
    //移动页统计
    var pages: [Int: Bool] = [:]
    // 背景总距离
//    var allDistance: CGFloat = 0
    //总计距离
    var moveDistance : CGFloat = 0
    // 游戏状态
    var isRuning = true
    
    //放置石头
    lazy var stoneImage: UIImageView = {
        let imageView = UIImageView(image: .fish)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        isRuning = false
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        view.backgroundColor = .red
        initBgV2()
        
        let datumboy = Datum.babuV13()
//        skeletonScript.isDebugPolygons = true
        skeletonScript.delegate = self
        
        source.loadStonesImages()
        
        Task {
            //            print(source.medals)
            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(80, 300 * ZKAdapt.factor, 180, 100),datum: datumboy)
            skeletonScript.scaleX(faceLeft: -1)
            skeletonScript.setAnimationName(animationName: CharaterBodyState.pao.rawValue,loop: true,timeScale: Float(moveSpeed)/4)
            guard let spineView = skeletonScript.spineUIView  else {
                print("spineUIView is nil")
                return
            }
            view.addSubview(spineView)
            
            let bgviews = [imageBgView,imageBgView2, imageBgView3]
            imageBgViews.append(contentsOf: bgviews)
            
            bgviews.forEach { createStone(view: $0, count: 10) }
            
//            let allDistance = imageBgViews.reduce(0, { $0 + $1.width })
//            print("allDistance: \(allDistance)")
            pages[0] = true
            
            isRuning = true
//            pages[1] = true
        }
    }
    
    
    private var state: CharaterBodyState = .animation;
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取spine点击点
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        guard isRuning else {
            return
        }
        
        if state == CharaterBodyState.feixing {
            return
        }
        
                state = .feixing
                skeletonScript.setAnimationName(animationName: state.rawValue,
                                                timeScale: 1.0) { [self] type, entry, event in
                    if type.SIEventType == .END ||
                        type.SIEventType == .COMPLETE{
//                        Task {
//                            UIView.animate(withDuration: 0.45) {
//                                spineUIView.y = 300 * ZKAdapt.factor
//                            }
//                        }
                        state = .pao
                        self.skeletonScript.setAnimationName(animationName: CharaterBodyState.pao.rawValue,loop: true,timeScale: Float(moveSpeed)/4)
                    }
                }
        
    }
    override func update() {
        guard isRuning else {
            return
        }
        
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        if state == .feixing {
            spineUIView.translate(CGPoint(x: 0, y: -4))
        } else if state == .pao {
            if spineUIView.y < 300 * ZKAdapt.factor {
                spineUIView.translate(CGPoint(x: 0, y: 4))
            }
        }
        
        //这张page的即将出现
        let currentIndex = Int(moveDistance)/UIDevice.width
//        print("pageIndex:\(pageIndex)")
        //中间一张移动一半时
        guard pages[currentIndex] == nil else {
            moveDistance += moveSpeed
            //移动背景
            imageBgViews.forEach { $0.translateToLeft(moveSpeed) }
            return
        }
       
        pages[currentIndex] = true
        print("currentIndex:\(currentIndex)")
//        print("moveDistance:\(moveDistance)")
//        //调整位置
        
//        //即将消失的索引，示例值：0,1,2
        let disAppearImageIndex = (currentIndex - 1).remainderReportingOverflow(dividingBy: imageBgViews.count).partialValue
        print("disAppearImageIndex:\(disAppearImageIndex)")
//        // 上个图片索引
        var afterImageIndex = disAppearImageIndex - 1
//        // 第一张放置最后
        if afterImageIndex < 0 {
            afterImageIndex = imageBgViews.count - 1
        }
        print("afterImageIndex:\(afterImageIndex)")
        //第三张出现的时候
        jusetIndex(disAppearImageIndex: disAppearImageIndex, beforeImageIndex: afterImageIndex)
    }
    
    //
    func jusetIndex(disAppearImageIndex: Int,beforeImageIndex: Int) {
        imageBgViews[disAppearImageIndex].x = imageBgViews[beforeImageIndex].frame.maxX
        
        //重置消失的视图元素
        imageBgViews[disAppearImageIndex].subviews.forEach {
            if let image = $0 as? UIImageView {
                resetStone(stoneImage: image)
            }
        }
    }
    
    func resetStone(stoneImage: UIImageView) {
        //        stoneImage.y = -50
        let x = CGFloat.random(in: 0..<UIDevice.widthf - 50)
        let y = CGFloat.random(in: 20..<UIDevice.heightf - 80)
        stoneImage.snp.updateConstraints { make in
            make.top.equalTo(y)
            make.left.equalTo(x)
        }
        stoneImage.image = source.medals?.randomElement()
        stoneImage.backgroundColor = .clear
    }
}

//MARK: - 初始化背景
extension RunViewController {
    func initBgV2() {
        view.addSubview(imageBgView)
        imageBgView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(UIDevice.width)
        }

        view.addSubview(imageBgView2)
        imageBgView2.snp.makeConstraints { make in
            make.left.equalTo(imageBgView.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(UIDevice.width)
        }
        
        view.addSubview(imageBgView3)
        imageBgView3.snp.makeConstraints { make in
            make.left.equalTo(imageBgView2.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(UIDevice.width)
        }
        

        view.addSubview(pausebtn)
        pausebtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
        
    }
    
    //在此视图创建
    func createStone(view: UIView, count: Int) {
        for _ in 0..<count {
            let stoneImage = UIImageView(image: .fish)
            stoneImage.contentMode = .scaleAspectFit
            view.addSubview(stoneImage)
            stoneImage.snp.makeConstraints { make in
                make.top.equalTo(UIDevice.height/2 - 50)
                make.left.equalTo(UIDevice.width/2)
                make.size.equalTo(CGSize(width: 50, height: 50))
            }
            resetStone(stoneImage: stoneImage)
//            print(view.subviews.count)
        }
        
    }
}

extension RunViewController: SkeletonGraphicDelegate {
    func onUpdatePolygonsTransforms(skeletonGraphicScript: SkeletonGraphicScript) {
        
    }
    
    func onInitialized(skeletonGraphicScript: SkeletonGraphicScript) {
        
//        skeletonGraphicScript.debugBoxPoint()
    }
    
    func onAfterUpdateWorldTransforms(skeletonGraphicScript: SkeletonGraphicScript) {
        
    }
    
    func onTriggerEnter(other: UIView) {
        //        print("onTriggerEnter")
        if other.tag != 1, other.tag != 2 {
            //            print("onTriggerEnter")
            other.backgroundColor = .red
            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            //                other.removeFromSuperview()
            //            }
        }
    }
    
}

//MARK: 交互
extension RunViewController {
    
    @objc func pauseGame(){
        isRuning.toggle()
        pausebtn.setTitle(!isRuning ? "继续" : "暂停", for: .normal)
    }
}

@available(iOS 17.0,*)
#Preview {
    RunViewController()
}
