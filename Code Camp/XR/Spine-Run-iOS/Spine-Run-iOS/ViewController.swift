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

extension Datum {
    static func spineBoy() -> Datum {
        Datum(json: "spineboy-pro.json",
              atlas: "spineboy-pma.atlas")
    }
    
    static func babuV13() -> Datum {
        Datum(json: "babu_v1.3.json",
              atlas: "babu_v1.3.atlas")
    }
}

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
    
    //放置窗户
    lazy var demoBtn: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
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
    //点击屏幕保存方向距离
    private var targetspeed: CGPoint = .zero
    // 目标状态
    public var state: CharaterBodyState = .animation;
    
    //障碍物 绘制任务触发
    
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
//            try? await skeletonScript.setSkeletonFromBundle(rect:CGRectMake(lE.x, 120, 200, 200),datum: datumboy)
//            竖屏，不缩放
            try? await skeletonScript.setSkeletonFromBundle(rect:view.bounds,datum: datumboy)
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
        
        for slotRect in skeletonScript.slotsRect {
            
            if let att = slotRect.slot.attachment {
                
//                if att.aType == 4 {
                    let rView = UILabel()
                if att.aType == 3 {
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
                
//                    rView.text = (att.name ?? "") + "_\(att.aTypeStr)"

//                }
            }
 
//            rView.frame = CGRect(x: slotRect.rect.minX,
//                                 y: slotRect.rect.midY,
//                                 width: 100, height: 40)// boneRect.rect

        }
        
//        if let rect = skeletonScript.getBoneRectBy(boneName: "root") {
//            let rView = UIView()
//            rView.frame = rect
//            rView.backgroundColor = .blue
//            spineView.addSubview(rView)
//        } else {
//            print("get bone rect is nil")
//        }
        
        indicatorOffX = spineView.center
        self.view.addSubview(spineView)
    }
    
    func initCharePositionMiddle(spineView: UIView) {
        spineView.frame = CGRectMake(rE.x - UIDevice.widthf, 120, 200, 200)
        
    }
    
    //获取点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("touchesBegan")
        //获取spine点击点
        guard let spineUIView = skeletonScript.spineUIView  else { return  }
        if let touch = touches.first {
            let point = touch.location(in: view)
            
            if let rect = skeletonScript.getBoneRectBy(boneName: "root") {
                
            } else {
                print("get bone rect is nil")
            }
            // print("\(point.x)")
            // targeDistance = Float(point.x - spineUIView.x)
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
            skeletonScript.playAnimationName(
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
        skeletonScript.playAnimationName(
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
    }
}

@available(iOS 17.0,*)
#Preview(body: {
    ViewController()
})

