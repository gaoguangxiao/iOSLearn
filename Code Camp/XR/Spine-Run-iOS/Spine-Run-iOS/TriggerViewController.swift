//
//  TriggerViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/26.
//

import UIKit
import GGXSwiftExtension

class TriggerViewController: BehaviorViewController {
    
    let skeletonScript = SkeletonGraphicScript()
    
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .bgPhone)
//        imageView.contentMode = .scaleAspectF
        return imageView
    }()
    
    //放置石头
    lazy var stoneImage: UIImageView = {
        let imageView = UIImageView(image: .fish)
        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .red
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
        
        let datumboy = Datum.babuV13()
        skeletonScript.delegate = self
        
        Task {
            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(20, 250, 150, 100),datum: datumboy)
            guard let spineView = skeletonScript.spineUIView  else {
                print("spineUIView is nil")
                return
            }
            view.addSubview(spineView)

        }
    }
    
    //获取点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("touchesBegan")
        //获取spine点击点
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        if let touch = touches.first {
            //点击`spineUIView`添加黑点
            //            let point = touch.location(in: spineUIView)
            //                        //将点击点转化为spine的坐标
            //            skeletonScript.containsPoint(point: point)
            //            let rView = UILabel()
            //            rView.center = point
            //            rView.backgroundColor = .black
            //            rView.frame = CGRect(x: point.x, y: point.y, width: 10, height: 10)
            //            spineUIView.addSubview(rView)
            //            return
            
            // print("\(point.x)")
            // targeDistance = Float(point.x - spineUIView.x)
            let point = touch.location(in: view)
            moveDistance = .zero
            targeDistance = point - spineUIView.center
            //            print("targeDistance：\(targeDistance)")
            //朝向
            if targeDistance.x > 0 {
                skeletonScript.scaleX(faceLeft: -1)
            } else {
                skeletonScript.scaleX(faceLeft: 1)
            }
            
            //            if targeDistance.x > 0 && skeletonScript.skeleton?.scaleX != -1 {
            //更新spine世界点
//            self.skeletonScript.updateSlotPath()
            //重新渲染
//            self.debugSlotPathPoint()
            
            //}
            
            //走路状态改变一次
            guard state != .zoulu else {
                return
            }
            state = .zoulu
            skeletonScript.playAnimationName(
                animationName: CharaterBodyState.zoulu.rawValue,
                loop: true)
        }
    }
    
    //障碍物移动速度
    public var stoneSpeed: Float = 2.0
    
    var isRuning = true
    
    override func update() {
        
        guard isRuning else {
            return
        }
        
        if (targeDistance.x != 0) {
            let distance = (targeDistance.x > 0 ? CGPoint.right : CGPoint.left) * baseSpeed
            moveSkeObj(distance)
        }
        
        stoneImage.translate(CGPoint(x: 0, y: Int(1.0 * stoneSpeed)))

        if stoneImage.y >= UIDevice.heightf {
            resetStone()
        }
    }
    
    //重置坐标
    func resetStone() {
        stoneImage.y = 0
        stoneImage.x = CGFloat(arc4random_uniform(UInt32(UIDevice.widthf - 50)))
//        stoneImage.image =
//        print(<#T##items: Any...##Any#>)
    }
    
    /// 角色
    public enum CharaterBodyState: String
    {
        case animation
        case Idle
        case zoulu
        case zoulu_xianzhi
        case Running
        case Death
        case Jumping
    }
    
    // 目标距离
    private var targeDistance: CGPoint = .zero
    // 定义移动距离
    private var moveDistance: CGPoint = .zero
    // 基础速度
    private var baseSpeed: CGFloat = 4.0
    // 目标状态
    private var state: CharaterBodyState = .animation;
    
    //单位时间移动距离
    func moveSkeObj(_ distance: CGPoint) {
        guard let spineUIView = skeletonScript.spineUIView  else { return }
        //角色移动屏幕边缘
        //move right
        if distance.x > 0 && moveDistance.x >= targeDistance.x {
            stopMove()
            return
        }
        //move left
        if distance.x < 0 && moveDistance.x <= targeDistance.x {
            stopMove()
            return
        }
        //移动视图
        spineUIView.translate(distance)
        moveDistance.x += distance.x
    }
    
    func stopMove()  {
        state = .animation
        targeDistance = .zero
        skeletonScript.playAnimationName(
            animationName: CharaterBodyState.animation.rawValue,
            loop: false)
    }
    
}

//MARK: - 视图
extension TriggerViewController {
    func initBgV2() {
        view.addSubview(imageBgView)
        if let image = imageBgView.image {
            imageBgView.frame = CGRect(x: 0, y: 0, width: image.width, height: SCREEN_HEIGHT)
        }
        
        view.addSubview(stoneImage)
        stoneImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
//        view.addSubview(pausebtn)
//        pausebtn.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-50)
//            make.top.equalTo(20)
//            make.size.equalTo(CGSize(width: 80, height: 40))
//        }
        
        // 添加拖动手势识别器
        //        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        //        demoBtn.addGestureRecognizer(panGesture)
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

//MARK: - SkeletonGraphicDelegate
extension TriggerViewController: SkeletonGraphicDelegate {

    func onAfterUpdateWorldTransforms(skeletonGraphicScript: SkeletonGraphicScript) {
        
    }
    
    func onInitialized(skeletonGraphicScript: SkeletonGraphicScript) {
        //spine初始化完毕，渲染触发点
//        self.debugSlotPathPoint()
    }
    
    //
    func onTriggerEnter(other: UIView) {
        if other == stoneImage {
            resetStone()
        }
    }
}

//MARK: 交互
extension TriggerViewController {
    
    @objc func pauseGame(){
        isRuning.toggle()
    }
}

@available(iOS 17.0,*)
#Preview(body: {
    TriggerViewController()
})
