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
import GGXSwiftExtension

//前缀Spine-iOS缩写
typealias SIAnimationState = Spine.AnimationState

enum SkeletonGraphicError: Error {
    case DataError
}

// 骨骼
struct BoneRect: Hashable {
    let name: String
    let id: UUID
    let rect: CGRect
//    let x: CGFloat
//    let y: CGFloat
//    let width: CGFloat
//    let height: CGFloat
}

public class SkeletonGraphicScript: ObservableObject {
    
    //    var atlasFileName: String?
    
    //    var skeletonFileName: String?
    
    @Published
    var spineView: SpineView?
    
    @Published
    var spineUIView: SpineUIView?
    
    ///Corresponding to SpineView is skin data
    @Published
    var skins: [Skin]?
    
    @Published
    var bonesRect: [BoneRect] = []
    
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
    
    var scaleX: Float?
    
    //spine数据体
    private var skeletonDrawable: SkeletonDrawableWrapper?
    //皮肤
    private var customSkin: Skin?
    
    //皮肤数据
    @Published
    var partSkins: [SkinViewModel]?
    
    @Published
    var partAfterSkins: [SkinViewModel]?
    
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
    
    func configSkeletonDrawableWrapper(drawable: SkeletonDrawableWrapper, rect: CGRect) async throws {
        
        self.skeletonDrawable = drawable
        
        configSkeletonData(drawable.skeletonData)
                
        self.controller = SpineController(
            onInitialized: { [weak self ] controller in
                guard let self else { return }
//                LogInfo("EEE")
                //配置骨骼坐标
                if let bones = skeleton?.bones {
                    configBones(bones: bones)
                }
            }
        )
        
        await MainActor.run {
            
            self.spineView = nil
            
            self.spineView = SpineView(from: .drawable(drawable),
                                       controller: self.controller)
            
            
            self.spineUIView = SpineUIView(from: .drawable(drawable),
                                           controller: self.controller,
                                           backgroundColor: .white)
            self.spineUIView?.frame = rect
            
        }
    }
    
    // Configure bone animation data
    func configSkeletonData(_ skeletonData: SkeletonData) {
        
        //config skin data
        configSkins(skins: skeletonData.skins)
        
        //        skeletonData.animations.forEach {
        //            if let name = $0.name { print("skin.animation: \(name)") }
        //        }
        
        //        skeletonData.bones.forEach { bone in
        ////            if let name = bone.name { print("bone.animation: \(name)") }
        //            let color = bone.color  print("bone.color: \(color)")
        //        }
        
        //        skeletonData.events.forEach { event in
        //            print("event.description: \(event.description)")
        //        }
        //一个带有定点的附件
        //        BoundingBoxAttachment
        //        SkeletonBounds
    }
    
    
    @Published
    var selectedItem: String = ""
}

//MARK: - init SkeletonDrawableWrapper
extension SkeletonGraphicScript {
    
    public func setSkeletonFromBundle(rect: CGRect, datum: Datum) async throws {
        guard let atlas = datum.atlas ,let json = datum.json else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlas, skeletonFileName: json)
        try await configSkeletonDrawableWrapper(drawable: drawable, rect: rect)
        LogInfo("AAA")
        getBoneRectBy(boneName: "root")
    }
    
    public func setSkeletonFromBundle(datum: Datum) async throws {
        guard let atlas = datum.atlas ,let json = datum.json else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromBundle(atlasFileName: atlas, skeletonFileName: json)
        try await configSkeletonDrawableWrapper(drawable: drawable,rect: .zero)
    }
    
    public func setSkeletonFromFile(datum: Datum) async throws {
        guard let atlas = Bundle.main.path(forResource: datum.atlas, ofType: nil)?.fileUrl,
              let json = Bundle.main.path(forResource: datum.json, ofType: nil)?.fileUrl else {
            throw SkeletonGraphicError.DataError
        }
        let drawable = try await SkeletonDrawableWrapper.fromFile(atlasFile: atlas, skeletonFile: json)
        try await configSkeletonDrawableWrapper(drawable: drawable,rect: .zero)
    }
}

//MARK: 动作
extension SkeletonGraphicScript {
    
    public func playAnimationName(animationName: String, loop: Bool = false, reverse: Bool = false, timeScale: Float = 1.0) {
        guard let _ = skeletonData?.findAnimation(name: animationName) else {
            print("animation is nil")
            return
        }
        let trackEntry = animationState?.setAnimationByName(trackIndex: 0, animationName: animationName, loop: loop)
        trackEntry?.reverse = reverse
        trackEntry?.timeScale = timeScale
    }
    
    /// 控制朝向 默认
    public func scaleX(faceLeft: Float) {
        skeleton?.scaleX = faceLeft
    }
}

//MARK: 皮肤
extension SkeletonGraphicScript {
    
    // Initialize skin
    public func initCharaterSkin(_ skinName: String) {
        customSkin?.dispose()
        customSkin = Skin.create(name: "character-base")
        if let skin = skeletonData?.findSkin(name: skinName) {
            customSkin?.addSkin(other: skin)
        }
        
        if let customSkin {
            updateCombinedSkin(resultCombinedSkin: customSkin)
        }
    }
    
    /// combination skin
    public func combinedCharaterSkin(_ skinName: String) {
        let resultCombinedSkin = Skin.create(name: "character-combined")
        //Adds a new skin to the previous skin
        resultCombinedSkin.addSkin(other: resultCombinedSkin);
        
        if let skin = skeletonData?.findSkin(name: skinName) {
            customSkin?.addSkin(other: skin)
        }
        if let customSkin {
            updateCombinedSkin(resultCombinedSkin: customSkin)
        }
    }
    
    public func updateSkin(skinModel: SkinViewModel) -> Bool {
        guard skinModel.name == skinModel.all else {
            configPartSkins(skinModel: skinModel)
            return true
        }
        
        initCharaterSkin(skinModel.name)
        return false
    }
    
    //更新皮肤
    func updateCombinedSkin(resultCombinedSkin: Skin) {
        skeleton?.skin = resultCombinedSkin
        skeleton?.setToSetupPose()
    }
    
    //对皮肤数据进行拆分
    private func configSkins(skins: [Skin]) {
        
        //        skeletonData.skins.forEach {
        //            if let name = $0.name { print("skin.name: \(name)") }
        //        }
        
        //抛出皮肤数据
        Task {
            await MainActor.run {
                self.skins = skins
            }
        }
        
        //设置默认皮肤
        for skin in skins {
            if let name = skin.name  {
                if name == "default" { continue }
                initCharaterSkin(name)
                if name == "moren" {  break }
            }
        }
        
        //分离皮肤
        partSkins = skins.compactMap {
            guard let skinsplits = $0.name?.split("/"),
                  let skinSplitsFirst = skinsplits.first ,
                  let name = $0.name else {
                return nil
            }
            let skinModel = SkinViewModel(name: skinSplitsFirst, all: name)
            return skinModel
        }
        
        partSkins = partSkins?.reduce(into: [SkinViewModel]()) { partialResult, skinModel in
            if !partialResult.contains(where: { $0.name == skinModel.name }) {
                partialResult.append(skinModel)
            }
        }
    }
    
    //查看子部件
    private func configPartSkins(skinModel: SkinViewModel) {
        partAfterSkins = skins?.compactMap {
            guard let skinsplits = $0.name?.split("/"),
                  let name = $0.name ,
                  let skinSplitsLast = skinsplits.last,
                  name.contains(skinModel.name) else {
                //                print("-------nil")
                return nil
            }
            let skinModel = SkinViewModel(name: skinSplitsLast, all: name)
            return skinModel
        }
        
        partAfterSkins = partAfterSkins?.reduce(into: [SkinViewModel]()) { partialResult, skinModel in
            if !partialResult.contains(where: { $0.name == skinModel.name }) {
                partialResult.append(skinModel)
            }
        }
        
        selectedItem = skinModel.all
    }
}

//MARK: - 骨骼
extension SkeletonGraphicScript {
    
    private func configBones(bones: [Bone]) {
        //        bones.forEach { bone in
        //            if let name = bone.data.name { print("bone.name: \(name)") }
        //        }
        
        bonesRect = bones.map({ bone in
//            print("bone.worldX: \(bone.worldX)、bone.worldY: \(bone.worldY)")
            let position = controller.fromSkeletonCoordinatesToScreen(
                position: CGPointMake(CGFloat(bone.worldX), CGFloat(bone.worldY))
            )
            let rect = BoneRect(
                name:bone.data.name ?? "nil",
                id: UUID(),
                rect: CGRect(x: position.x,
                             y: position.y, width: 1, height: 1)
            )
//            print("position: \(position.x)、x.y: \(position.y)")
            return rect
        })
        
        //骨骼的世界坐标转换屏幕需要等待controller中scaleY赋值完成才能获取
//        if let boneFirst = bonesRect.first {
//            LogInfo("bone.first:\(String(describing: bonesRect.first))")
//        } else {
//            LogInfo("bone.first is nil")
//        }
    }
    
    func getBoneRectBy(boneName: String) -> CGRect? {
        //
        if let bone = skeleton?.findBone(boneName: "root") {
            print("world: \(bone.worldX)、x.y: \(bone.worldY)")
            let position = controller.fromSkeletonCoordinatesToScreen(
                position: CGPointMake(CGFloat(bone.worldX), CGFloat(bone.worldY))
            )
            let rect = CGRect(x: position.x,
                              y: position.y,
                              width: 5,
                              height: 5)
            print("position: \(position.x)、x.y: \(position.y)")
            return rect
        }
        return nil
    }
}

extension SkeletonGraphicScript {
    
    var skeleton: Skeleton? {
        self.skeletonDrawable?.skeleton
    }
    
    var skeletonData: SkeletonData? {
        self.skeletonDrawable?.skeletonData
        //        self.controller.drawable.skeletonData
    }
    
    var animationState: SIAnimationState? {
        self.skeletonDrawable?.animationState
    }
}

//
extension SpineController {
    
    //转换UIView屏幕，X的位置需要增加屏幕一半
    public func fromSkeletonCoordinatesToScreen(position: CGPoint) -> CGPoint {
        let orignPosition = self.fromSkeletonCoordinates(position: position)
        let x = orignPosition.x;
        let y = orignPosition.y;
        return CGPoint(
            x: x + viewSize.width/2,
            y: y + viewSize.height/2
        )
    }
    
}
//extension SpineUIView {
//
//    //转换某个坐标
//    public func translate(_ translation: CGPoint) {
//        //朝向移动
//        self.center += translation
//    }
//}

//#MARK: - 模型数据
public struct Datum: Identifiable, SmartCodable {
    public var id: Int?
    public var name: String?
    public var json, atlas: String?
    public var atlasURL, jsonURL: String?
    
    public init() {
        
    }
    
    public init(json: String,
                atlas: String) {
        self.json = json
        self.atlas = atlas
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

//业务展示的model
public class SkinViewModel: Identifiable, ObservableObject {
    public var id = UUID()
    
    @Published
    var name: String
    
    @Published
    var all: String
    
    init(id: UUID = UUID(), name: String, all: String) {
        self.id = id
        self.name = name
        self.all = all
    }
}
