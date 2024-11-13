//
//  SkeletonGraphicScript.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
// SkeletonGraphicScript：
// 1、对`Datum`封装，可以根据bundle、file、http初始化spine视图

import Foundation
import Spine
import SwiftUICore
import SmartCodable

//前缀Spine-iOS缩写
typealias SIAnimationState = Spine.AnimationState

enum SkeletonGraphicError: Error {
    case DataError
}

public class SkeletonGraphicScript: ObservableObject {
    
//    var atlasFileName: String?
    
//    var skeletonFileName: String?
    
    @Published
    var spineView: SpineView?
    
//    @Published
    var controller: SpineController
    
//    @Published
    var drawable: SkeletonDrawableWrapper?
    
    @State
    var isRendering: Bool?
    
    //动作方向
//    public var reverse: Bool = true
    
    // 速度
//    public var timeScale: Float = 1.0;
    
    //spine数据体
    private var skeletonDrawable: SkeletonDrawableWrapper?
    //皮肤
    private var customSkin: Skin?
    
    init() {
        controller = SpineController(
            onInitialized: { controller in
//                controller.animationState.setAnimationByName(
//                    trackIndex: 0,
//                    animationName: "animation",
//                    loop: true
//                )
            }
        )
    }
    
    func configSkeletonDrawableWrapper(drawable: SkeletonDrawableWrapper) async throws {
        
        self.skeletonDrawable = drawable
        
        configSkeletonData(drawable.skeletonData)

        //设置默认皮肤
        for skin in drawable.skeletonData.skins {
            if let name = skin.name  {
                if name == "default" { continue }
                initCharaterSkin(skinName: name)
                if name == "moren" {  break }
            }
        }
        
        self.controller = SpineController()
        
        await MainActor.run {
//            self.isRendering = true
//            self.drawable = drawable
            self.spineView = nil
            
            Task.detached {
                await MainActor.run {
                    self.spineView = SpineView(from: .drawable(drawable),
                                                         controller: self.controller)
                }
            }
            
        }
    }
    
    // Initialize skin
    func initCharaterSkin(skinName: String) {
        
        customSkin?.dispose()
        customSkin = Skin.create(name: "character-base")
        if let skin = skeletonData?.findSkin(name: skinName) {
            customSkin?.addSkin(other: skin)
        }
        
        if let customSkin {
            updateCombinedSkin(resultCombinedSkin: customSkin)
        }
    }
    
    //更新皮肤
    func updateCombinedSkin(resultCombinedSkin: Skin) {
        skeleton?.skin = resultCombinedSkin
        skeleton?.setToSetupPose()
    }
    
    // Configure bone animation data
    func configSkeletonData(_ skeletonData: SkeletonData) {
        
        skeletonData.skins.forEach {
            if let name = $0.name { print("skin.name: \(name)") }
        }
        
//        skeletonData.animations.forEach {
//            if let name = $0.name { print("skin.animation: \(name)") }
//        }
    }
}

//MARK: - init SkeletonDrawableWrapper
extension SkeletonGraphicScript {
    
    public func setSkeletonFromBundle(datum: Datum) async throws {
        guard let atlas = datum.atlas ,let json = datum.json else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlas, skeletonFileName: json)
        try await configSkeletonDrawableWrapper(drawable: drawable)
    }
    
    public func setSkeletonFromFile(datum: Datum) async throws {
        guard let atlas = Bundle.main.path(forResource: datum.atlas, ofType: nil)?.toFileUrl,
              let json = Bundle.main.path(forResource: datum.json, ofType: nil)?.toFileUrl else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromFile(atlasFile: atlas, skeletonFile: json)
        try await configSkeletonDrawableWrapper(drawable: drawable)
    }
}

//MARK: 动作
extension SkeletonGraphicScript {
    
    public func playAnimationName(animationName: String, loop: Bool = false, reverse: Bool = false, timeScale: Float = 1.0) {
        let trackEntry = animationState?.setAnimationByName(trackIndex: 0, animationName: animationName, loop: loop)
        trackEntry?.reverse = reverse
        trackEntry?.timeScale = timeScale
    }
}

extension SkeletonGraphicScript {
    
    var skeleton: Skeleton? {
        self.skeletonDrawable?.skeleton
    }
    
    var skeletonData: SkeletonData? {
        self.skeletonDrawable?.skeletonData
    }
    
    var animationState: SIAnimationState? {
        self.skeletonDrawable?.animationState
    }
}

public struct Datum: Identifiable, SmartCodable {
    public var id: Int?
    public var name: String?
    public var json, atlas: String?
    public var atlasURL, jsonURL: String?
    
    public init(){
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case json = "JSON"
        case atlas = "Atlas"
        case atlasURL = "AtlasURL"
        case jsonURL = "JSONURL"
    }
}
