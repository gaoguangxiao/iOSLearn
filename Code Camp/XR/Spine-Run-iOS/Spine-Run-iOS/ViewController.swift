//
//  ViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/14.
//  点击移动角色

import UIKit
import Spine
import GGXSwiftExtension
import SnapKit



class ViewController: BehaviorViewController {
    
    let skeletonScript = SkeletonGraphicScript()
    
    let source = SkeletonSource()
    
    lazy var spineSuperView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .bgHuban)
        imageView.backgroundColor = .yellow
        imageView.isUserInteractionEnabled = true
        //        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var stones: [UIButton] = []

    lazy var updateBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("升级", for: .normal)
        //        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(didUpdateSpine), for: .touchUpInside)
        return btn
    }()
    
    //距离左边20停止
    private var lE: CGPoint = CGPoint(x: 200, y: 0)
    //距离右边20停止
    private var rE: CGPoint = CGPoint(x: 20, y: 0)
    //统计角色距离距离左边整个的偏移
    private var indicatorOffX: CGPoint = .zero
    // 目标距离
    private var targeDistance: CGPoint = .zero
    // 定义移动距离
    private var moveDistance: CGPoint = .zero
    // 基础速度
    private var baseSpeed: CGFloat = 4.0
//    //点击屏幕保存方向距离
//    private var targetspeed: CGPoint = .zero
    // 目标状态
    public var state: CharaterBodyState = .animation;
    
    //障碍物移动速度
//    public var stoneSpeed: Float = 2.0
    
    //    public
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //直接图片为背景
        initBgV2()
        // spineSuperView.frame = CGRectMake(20, 120, 200, 200)
        //  self.view.addSubview(spineSuperView)
        let datumboy = Datum.babuV13()
        
        //      spine-boy
        Task {
            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(lE.x, 250, 150, 100),datum: datumboy)
            //            竖屏，不缩放
            //try? await skeletonScript.setSkeletonFromBundle(rect:view.bounds,datum: datumboy)
            initSpineView()
        }
        
        //      NPC-spine
        //        Task {
        //            await source.loadCharaterJSON()
        //            if let datum = source.npcDatum {
        ////                try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(lE.x, 120, 200, 200),datum: datum)
        //                try? await skeletonScript.setSkeletonFromBundle(rect:view.bounds,datum: datum)
        //                skeletonScript.playAnimationName(
        //                    animationName: CharaterBodyState.animation.rawValue,
        //                    loop: true)
        //                skeletonScript.scaleX(faceLeft: -1)
        //                initSpineView()
        //            }
        //        }
    }
    
    func initSpineView() {
        guard let spineView = skeletonScript.spineUIView  else {
            print("spineUIView is nil")
            return
        }
        
        //        for boneRect in skeletonScript.bonesRect {
        //            let rView = UILabel()
        //            rView.text = boneRect.name
        //            rView.frame = CGRect(x: boneRect.rect.minX,
        //                                 y: boneRect.rect.midY,
        //                                 width: 100, height: 40)// boneRect.rect
        //            rView.backgroundColor = .blue
        //            spineView.addSubview(rView)
        //        }
        //
        //渲染spine动画路径
        //        debugSlotViewPoint(spineView: spineView)
        
        //spine路径多边形点
//        debugSlotPathPoint()
        
        //        if let rect = skeletonScript.getBoneRectBy(boneName: "root") {
        //            let rView = UIView()
        //            rView.frame = rect
        //            rView.backgroundColor = .blue
        //            spineView.addSubview(rView)
        //        } else {
        //            print("get bone rect is nil")
        //        }
        
        indicatorOffX = spineView.center
        view.addSubview(spineView)
    }
    
//    func debugSlotPathPoint() {
//        guard let spineView = skeletonScript.spineUIView  else {
//            print("spineUIView is nil")
//            return
//        }
//        
//        //先移除
//        for view in spineView.subviews {
//            view.removeFromSuperview()
//        }
//        
//        //渲染路径
//        for boxRect in skeletonScript.boxRect {
//            let rView = UILabel()
//            rView.frame = CGRect(x: boxRect.x,
//                                 y: boxRect.y,
//                                 width: 5, height: 5)// boneRect.rect
//            rView.backgroundColor = .yellow
//            spineView.addSubview(rView)
//        }
//    }
    
    func debugSlotViewPoint() {
        guard let spineView = skeletonScript.spineUIView  else {
            print("spineUIView is nil")
            return
        }
        for slotRect in skeletonScript.slotsRect {
            if let att = slotRect.slot.attachment {
                let rView = UILabel()
                if att.rType == .BOUNDING_BOX {
                    rView.backgroundColor = .red
                    spineView.addSubview(rView)
                    rView.snp.makeConstraints { make in
                        make.left.equalTo(slotRect.rect.minX)
                        make.top.equalTo(slotRect.rect.midY)
                        make.size.equalTo(CGSize(width: 10, height: 10))
                    }
                } else {
                    rView.backgroundColor = .blue
                    spineView.addSubview(rView)
                    rView.snp.makeConstraints { make in
                        make.left.equalTo(slotRect.rect.minX)
                        make.top.equalTo(slotRect.rect.midY)
                        make.size.equalTo(CGSize(width: 10, height: 10))
                    }
                    
                }
            }
        }
    }
    
//    func debugPointView() {
//        //100 * 40个石头
//        for i in 0 ..< 50 {
//            for j in 0 ..< 15 {
//                let rView = UIButton()
//                rView.frame = CGRect(x: i * 10 + 200,
//                                     y: j * 10 + 200,
//                                     width: 5, height: 5)// boneRect.rect
//                rView.backgroundColor = .green
//                view.addSubview(rView)
//                stones.append(rView)
//            }
//        }
//    }
    
    func initCharePositionMiddle(spineView: UIView) {
        spineView.frame = CGRectMake(rE.x - UIDevice.widthf, 120, 200, 200)
        
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
            
            //走路状态改变一次
            guard state != .zoulu else {
                return
            }
            state = .zoulu
            skeletonScript.setAnimationName(
                animationName: CharaterBodyState.zoulu.rawValue,
                loop: true)
        }
    }
    
    // 实现父类定时功能
    override func update() {
        //移动角色
        if (targeDistance.x != 0) {
            //角色和背景交替移动【任务左边或者人物右边，右边偏移间距减去任务当前距离】
            if indicatorOffX.x <= UIDevice.widthf/2 || rE.x - indicatorOffX.x <= UIDevice.widthf/2 {
                let distance = (targeDistance.x > 0 ? CGPoint.right : CGPoint.left) * baseSpeed
                moveSkeObj(distance)
            } else {
                let distance = (targeDistance.x > 0 ? CGPoint.left : CGPoint.right) * baseSpeed
                moveBgObj(distance)
            }
        } else {
            
        }
    }
}

//MARK: - 角色移动
extension ViewController {
    
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
        indicatorOffX += distance
        //        print("moveDistance: \(moveDistance)")
    }
    
    func moveBgObj(_ distance: CGPoint) {
        //        print("distance: \(distance)")
        //move right
        if distance.x > 0 && moveDistance.x <= targeDistance.x {
            stopMove()
            return
        }
        //bg move
        if distance.x < 0 && moveDistance.x >= targeDistance.x {
            stopMove()
            return
        }
        imageBgView.translate(distance)
        moveDistance.x -= distance.x
        indicatorOffX -= distance
    }
    
    func stopMove()  {
        state = .animation
        targeDistance = .zero
        skeletonScript.setAnimationName(
            animationName: CharaterBodyState.animation.rawValue,
            loop: false)
    }
}

//MARK: - 初始化背景
extension ViewController {
    func initBgV2() {
        view.addSubview(imageBgView)
        if let image = imageBgView.image {
            imageBgView.frame = CGRect(x: 0, y: 0, width: image.width, height: SCREEN_HEIGHT)
            
            rE = CGPoint(x: image.width - 20, y: 0)
        }
        
        view.addSubview(updateBtn)
        updateBtn.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}



//MARK: 点击事件
extension ViewController {
    @objc func didUpdateSpine() {
        let nv = UpdateSpinViewController()
        push(nv)
        
        //将按钮的点转移至spine点
//        skeletonScript.containsPoint(point: demoBtn.center)
        
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let draggableView = gesture.view else { return }
        
        // 获取手势的偏移量
        let translation = gesture.translation(in: view)
        
        // 更新视图的位置
        draggableView.center = CGPoint(x: draggableView.center.x + translation.x,
                                       y: draggableView.center.y + translation.y)
        
        // 重置手势的偏移量（防止累积）
        gesture.setTranslation(.zero, in: view)
        
        // 可选：根据手势状态执行额外操作
        if gesture.state == .ended {
            print("拖动结束")
        }
    }
}

@available(iOS 17.0,*)
#Preview(body: {
    ViewController()
})

