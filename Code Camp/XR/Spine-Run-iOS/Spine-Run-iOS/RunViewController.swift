//
//  RunViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/28.
//

import UIKit

class RunViewController: BehaviorViewController {
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .a5922Dbfe3F7B5F4Cca6B3Cd83497106)
        imageView.isUserInteractionEnabled = true
        imageView.tag = 1
        return imageView
    }()
    
    lazy var imageBgView2: UIImageView = {
        let imageView = UIImageView(image: .a5922Dbfe3F7B5F4Cca6B3Cd83497106)
        imageView.isUserInteractionEnabled = true
//        imageView.backgroundColor = .black
        imageView.tag = 2
        return imageView
    }()
    
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
    var moveSpeed: Float = 4
    //移动页
    var pages: [Int: Int] = [:]
    //总计距离
    var moveDistance = 0
    // 游戏状态
    var isRuning = true
    
    //放置石头
    lazy var stoneImage: UIImageView = {
        let imageView = UIImageView(image: .fish)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        view.backgroundColor = .red
        initBgV2()
        
        let datumboy = Datum.babuV13()
        skeletonScript.delegate = self
        
        Task {
            await source.loadStonesImages()
            //            print(source.medals)
            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(80, 200, 120, 150),datum: datumboy)
            skeletonScript.scaleX(faceLeft: -1)
            skeletonScript.setAnimationName(animationName: CharaterBodyState.pao.rawValue,loop: true,timeScale: moveSpeed/4)
            guard let spineView = skeletonScript.spineUIView  else {
                print("spineUIView is nil")
                return
            }
            view.addSubview(spineView)
                
            createStone(view: imageBgView, count: 50)
            createStone(view: imageBgView2, count: 50)
        }
    }
    
    private var state: CharaterBodyState = .animation;
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取spine点击点
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        guard isRuning else {
            return
        }
        
        
        if state == CharaterBodyState.Jumping {
            return
        }

//        Task {
//            UIView.animate(withDuration: 0.55) {
//                spineUIView.y = 130
//            }
//        }
//        
//        state = .Jumping
//        skeletonScript.setAnimationName(animationName: CharaterBodyState.Jumping2.rawValue,timeScale: 1.0) { [self] type, entry, event in
//            if type.SIEventType == .END ||
//                type.SIEventType == .COMPLETE{
//                Task {
//                    UIView.animate(withDuration: 0.15) {
//                        spineUIView.y = 200
//                    }
//                }
//                state = .pao
//                self.skeletonScript.setAnimationName(animationName: CharaterBodyState.pao.rawValue,loop: true,timeScale: moveSpeed/4)
//            }
//        }
   
    }
    override func update() {
        guard isRuning else {
            return
        }
        let pageIndex = moveDistance/UIDevice.width
        
        guard moveDistance >= UIDevice.width, pages[pageIndex] == nil else {
            let distance = 1 * moveSpeed
            moveDistance += Int(distance)
            imageBgView.translate(CGPoint(x: Int(-distance), y: 0))
            imageBgView2.translate(CGPoint(x: Int(-distance), y: 0))
            return
        }
        //        print("pageIndex: \(pageIndex) - page:\(page)")
        if pageIndex%2 == 0 {
            print("调整：imageBgView2")
            imageBgView2.x = imageBgView.frame.maxX
//            print("resetStone:\(imageBgView2.subviews.count)")
            for subview in imageBgView2.subviews {
                if let image = subview as? UIImageView {
                    resetStone(stoneImage: image)
                }
            }
            
            //控制检测视图
//            skeletonScript.triggerView = imageBgView2
        } else {
            print("调整：imageBgView")
            imageBgView.x = imageBgView2.frame.maxX
            for subview in imageBgView.subviews {
                if let image = subview as? UIImageView {
                    resetStone(stoneImage: image)
                }
            }
//            skeletonScript.triggerView = imageBgView
        }
        pages[pageIndex] = pageIndex
    }
    
    func resetStone(stoneImage: UIImageView) {
//        stoneImage.y = -50
        let x = CGFloat(Float.random(in: 0..<Float(UIDevice.widthf) - 40))
        let y = CGFloat(Float.random(in: 100..<Float(UIDevice.height) - 80))
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
        
//        imageBgView.addSubview(createStone())
        
        view.addSubview(imageBgView2)
        imageBgView2.snp.makeConstraints { make in
            make.left.equalTo(imageBgView.snp.right)
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
            print(view.subviews.count)
        }
       
    }
    
    func debugSlotPathPoint() {
        guard let spineView = skeletonScript.spineUIView  else {
            print("spineUIView is nil")
            return
        }
        
        //先移除
        for view in spineView.subviews {
            view.removeFromSuperview()
        }
        
        //渲染路径
        for boxRect in skeletonScript.boxRect {
            let rView = UILabel()
            rView.frame = CGRect(x: boxRect.x,
                                 y: boxRect.y,
                                 width: 5, height: 5)// boneRect.rect
            rView.backgroundColor = .purple
            spineView.addSubview(rView)
        }
        
//        LogInfo("debugSlotPathPoint finish")
    }
    
}

extension RunViewController: SkeletonGraphicDelegate {
    func onInitialized(skeletonGraphicScript: SkeletonGraphicScript) {
//        debugSlotPathPoint()
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
