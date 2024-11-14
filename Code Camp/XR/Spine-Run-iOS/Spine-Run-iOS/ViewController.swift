//
//  ViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/14.
//

import UIKit

class ViewController: UIViewController {
    
    let skeletonScript = SkeletonGraphicScript()
    
    let source = SkeletonSource()
    
    lazy var spineSuperView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bgScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.backgroundColor = .red
        scrollView.bounces = false
//        scrollView.p
        return scrollView
    }()
    lazy var imageBgView: UIImageView = {
        let imageView = UIImageView(image: .bgHuban)
        imageView.backgroundColor = .yellow
//        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("device width: \(view.bounds)")
        print("imageBgView.image.width: \(imageBgView.image?.width)")
        
        bgScrollView.frame = view.bounds
        bgScrollView.contentSize = CGSize(width: imageBgView.image?.width ?? 0, height: 0)
        view.addSubview(bgScrollView)
        
        //设置偏移量
        bgScrollView.setContentOffset(CGPoint(x: 45, y: 0), animated: true)
        
        print("bgScrollView.size: \(bgScrollView.bounds)")
        print("bgScrollView.contentSize: \(bgScrollView.contentSize)")
//        imageBgView.frame = CGRect(x: 0, y: 0, width: bgScrollView.contentSize.width/2, height: bgScrollView.contentSize.height)
        bgScrollView.addSubview(imageBgView)
        
        
        //视图背景定时移动 实现类、渲染协议
//        CADisplayLink
        
        //
        
        spineSuperView.frame = CGRectMake(20, 120, 200, 200)
//        spineSuperView.backgroundColor = .red
        self.view.addSubview(spineSuperView)
        
        Task {
            await source.loadCharaterJSON()
            
            if let datas = source.datas,
               let datum = datas.first {
                try? await skeletonScript.setSkeletonFromFile(datum: datum)
                
                //
                skeletonScript.playAnimationName(animationName: "pao",loop: true)
                skeletonScript.scaleX(faceLeft: -1)
//                print("load spine-12")
                await MainActor.run {
                    if let spineView = skeletonScript.spineUIView {
//                        print("load spine")
                        spineView.frame = self.spineSuperView.bounds
                        self.spineSuperView.addSubview(spineView)
                    }
                }
            }
        }
    }
        
    //
    func update() {
        print("A")
    }
}

@available(iOS 17.0,*)
#Preview(body: {
    ViewController()
})

