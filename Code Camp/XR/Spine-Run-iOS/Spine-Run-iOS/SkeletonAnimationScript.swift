//
//  SkeletonAnimationScript.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/26.
//

import Foundation
import GGXSwiftExtension

public enum CharaterBodyState: String
{
    case animation
    case Idle
    case zoulu
    case zoulu_xianzhi
    case pao
    case Death
    case Jumping
}

public class SkeletonAnimationScript: SkeletonGraphicScript {
    // 已经移动的距离
    private var moveDistance: CGPoint = .zero
    // 人物移动vector
    private var moveVector: CGPoint = .zero
    // 人物状态
    private var state: CharaterBodyState = .animation;
    
    // 待移动的距离
    public var targeDistance: CGPoint = .zero
    // 人物移动速度
    public var baseSpeed: CGFloat = 4.0
    
    override func onAfterPaint() {
        super.onAfterPaint()
        
        moveToPoint(moveVector)
    }
    
    public func runToDistance(distance: CGPoint){
        
        targeDistance = distance
        
        //改变朝向
        if targeDistance.x > 0 {
            scaleX(faceLeft: -1)
        } else {
            scaleX(faceLeft: 1)
        }
        
        moveDistance = .zero
        //要移动的方向和速度
        moveVector = (targeDistance.x > 0 ? CGPoint.right : CGPoint.left) * baseSpeed
        
        if state == .pao {
            return
        }
        state = .pao
        playAnimationName(
                animationName: state.rawValue,
                loop: true)
            
    }
    
    //单位时间移动距离
    private func moveToPoint(_ point: CGPoint) {
        guard let spineUIView  else { return }
        //角色移动屏幕边缘
        //move right
        if point.x > 0 && moveDistance.x >= targeDistance.x {
            stopMove()
            return
        }
        //move left
        if point.x < 0 && moveDistance.x <= targeDistance.x {
            stopMove()
            return
        }
        //移动视图
        spineUIView.translate(point)
        moveDistance.x += point.x
    }
    
    private func stopMove()  {
        state = .animation
        targeDistance = .zero
        playAnimationName(
            animationName: state.rawValue,
            loop: false)
    }
}
