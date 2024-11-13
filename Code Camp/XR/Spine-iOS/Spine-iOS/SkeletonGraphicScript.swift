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
    
    var atlasFileName: String?
    
    var skeletonFileName: String?
    
    @Published
    var controller: SpineController
    
    @Published
    var drawable: SkeletonDrawableWrapper?
    
    @State
    var isRendering: Bool?
    
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
        
        guard let atlasFileName, let skeletonFileName else {
            return
        }
        
        Task.detached {
            do {
                let drawable = try await SkeletonDrawableWrapper.fromBundle(
                    atlasFileName: atlasFileName,
                    skeletonFileName: skeletonFileName
                )
                await MainActor.run {
                    self.drawable = drawable
                }
            } catch  {
                print("\(error)")
            }
        }
    }
    
    func updateAsset(atlasFileName: String, jsonPathName: String) async throws {
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlasFileName, skeletonFileName: jsonPathName)
        //获取其皮肤
        initSkinSkeletonData()

        await MainActor.run {
            self.isRendering = true
            self.drawable = drawable
            self.controller = SpineController()
        }
    }
    
    func updateAssetFromBundle(datum: Datum) async throws {
        guard let atlas = datum.atlas ,let json = datum.json else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlas, skeletonFileName: json)
        
        await MainActor.run {
            self.isRendering = true
            self.drawable = drawable
            self.controller = SpineController()
            print("update su:\(atlas) :\(json)")
        }
    }
    
    //筛选皮肤数据
    func initSkinSkeletonData() {
        guard let skins = drawable?.skeletonData.skins else {
            return
        }
        for skin in skins {
            print("skin:\(skin)")
        }
    }
}
