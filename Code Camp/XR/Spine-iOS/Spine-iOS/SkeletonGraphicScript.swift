//
//  SkeletonGraphicScript.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import Foundation
import Spine
import SwiftUICore

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
        
//        guard let atlasFileName, let skeletonFileName else {
//            return
//        }
        
//        Task.detached {
//            do {
//                let drawable = try await SkeletonDrawableWrapper.fromBundle(
//                    atlasFileName: atlasFileName,
//                    skeletonFileName: skeletonFileName
//                )
//                await MainActor.run {
//                    self.drawable = drawable
//                }
//            } catch  {
//                print("\(error)")
//            }
//        }
    }
    
    
    func updateAssetFromBundle(datum: Datum) async throws {
        guard let atlas = datum.atlas ,let json = datum.json else {
            throw SkeletonGraphicError.DataError
        }
        try await updateAsset(atlasFileName: atlas, jsonPathName: json)
    }
    
    func updateAsset(atlasFileName: String, jsonPathName: String) async throws {
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlasFileName, skeletonFileName: jsonPathName)

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

extension SkeletonGraphicScript {
    
    var skeleton: Skeleton? {
        self.skeletonDrawable?.skeleton
    }
    
    var skeletonData: SkeletonData? {
        self.skeletonDrawable?.skeletonData
    }
}
