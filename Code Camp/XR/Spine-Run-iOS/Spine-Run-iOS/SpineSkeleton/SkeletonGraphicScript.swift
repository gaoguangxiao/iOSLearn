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
import SpineCppLite

//前缀Spine-iOS缩写
typealias SIAnimationState = Spine.AnimationState
typealias SIAnimation = Spine.Animation

enum SkeletonGraphicError: Error {
    case DataError
}

// 骨骼
struct BoneRect: Hashable {
    let name: String
    let id: UUID
    let rect: CGRect
}

struct SlotRect: Hashable {
    let slot: Slot
    let rect: CGRect
}

public protocol SkeletonGraphicDelegate {
    
    ///spine控制器初始化完成
    func onInitialized(skeletonGraphicScript: SkeletonGraphicScript)
    
    //世界坐标更新之后
    func onAfterUpdateWorldTransforms(skeletonGraphicScript: SkeletonGraphicScript)
    
    //其他对象进入spine内部，spineSuperView必须有值，同一图层
    func onTriggerEnter(other: UIView)
    
    //spine对象多边形变化
    func onUpdatePolygonsTransforms(skeletonGraphicScript: SkeletonGraphicScript)
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
    
    @Published
    var slotsRect: [SlotRect] = []
    
    public var isDebugPolygons = false
//    @Published
    var boxRects: [CGPoint] = []
    
    //spine插槽，绑定到骨骼
    @Published
    var slots: [Slot] = []
    
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
    
    public var delegate: SkeletonGraphicDelegate?
    
    public var bounds: SkeletonBounds?
    
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
                //配置骨骼坐标
                //                if let bones = skeleton?.bones {
                configBones(bones: controller.skeleton.bones)
                //                }
                
                //配置插槽
                configSlots(slots: controller.skeleton.slots)
                
                delegate?.onInitialized(skeletonGraphicScript: self)
            },
            onAfterUpdateWorldTransforms: { [weak self ] controller in
                guard let self else { return }
                
                Task.detached {
                    await self.onTriggerCheck()
                }
                
                onAfterUpdateWorldTransforms()
                
                delegate?.onAfterUpdateWorldTransforms(skeletonGraphicScript: self)
            },
            onAfterPaint: { controller in
                self.onAfterPaint()
            }
        )
        
        await MainActor.run {
            
            self.spineView = nil
            
            self.spineView = SpineView(from: .drawable(drawable),
                                       controller: self.controller)
            
            
            self.spineUIView = SpineUIView(from: .drawable(drawable),
                                           controller: self.controller,
                                           backgroundColor: .clear)
            self.spineUIView?.frame = rect
            
        }
    }
    
    // Configure bone animation data
    func configSkeletonData(_ skeletonData: SkeletonData) {
        
        //config skin data
        configSkins(skins: skeletonData.skins)
        
        
        configAnimations(animations: skeletonData.animations)
        
        
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
    
    func onAfterUpdateWorldTransforms() {
        
    }
    
    
    func onAfterPaint() {
        
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

//MARK: - 动作
extension EventType {
    
    //    typedef enum spine_event_type {
    //        SPINE_EVENT_TYPE_START = 0,//动画开始事件
    //        SPINE_EVENT_TYPE_INTERRUPT,//动画中断事件。
    //        SPINE_EVENT_TYPE_END,//动画播放到最后一帧时触发，通常用于清理或标记动画的完成。
    //        SPINE_EVENT_TYPE_COMPLETE,//当动画完整地播放了一次循环后触发。若动画是无限循环的，这个事件会在每次循环结束时触发
    //        SPINE_EVENT_TYPE_DISPOSE,//触发时机: 当动画资源被释放或被销毁时触发，适合用来清理资源或引用
    //        SPINE_EVENT_TYPE_EVENT//在动画中插入的关键帧事件触发时调用。可用于实现音效、特效等行为
    //    } spine_event_type;
    var SIEventType: SpineEventType {
        switch self {
        case SPINE_EVENT_TYPE_START: .START
        case SPINE_EVENT_TYPE_INTERRUPT: .INTERRUPT
        case SPINE_EVENT_TYPE_END: .END
        case SPINE_EVENT_TYPE_COMPLETE: .COMPLETE
        case SPINE_EVENT_TYPE_DISPOSE: .DISPOSE
        case SPINE_EVENT_TYPE_EVENT: .EVENT
        default: .END
        }
    }
}

public enum SpineEventType: String {
    case START
    case INTERRUPT
    case END
    case COMPLETE
    case DISPOSE
    case EVENT
}

extension SkeletonGraphicScript {
    

    
    private func configAnimations(animations: [SIAnimation]) {
//        animations.forEach {
//            if let name = $0.name { print("animation: \(name)") }
//        }
    }
    
    public func setAnimationName(trackIndex: Int = 0,
                                  animationName: String,
                                  loop: Bool = false,
                                  reverse: Bool = false,
                                  timeScale: Float = 1.0,
                                  isClearEnd: Bool = true,
                                  listener: AnimationStateListener? = nil) {
        guard let _ = skeletonData?.findAnimation(name: animationName) else {
            print("animation is nil")
            return
        }
        let trackEntry = animationState.setAnimationByName(trackIndex: Int32(trackIndex), animationName: animationName, loop: loop)
        setTrackEntry(trackEntry: trackEntry, reverse: reverse,timeScale: timeScale,isClearEnd: isClearEnd,listener: listener)
    }
    
    //一个轨道一个动画，如果要实现同一轨道多个动画需要叠加
    public func addAnimationName(trackIndex: Int = 0,
                                 animationName: String,
                                 loop: Bool = false,
                                 reverse: Bool = false,
                                 timeScale: Float = 1.0,
                                 isClearEnd: Bool = true,
                                 listener: AnimationStateListener? = nil) {
        guard let _ = skeletonData?.findAnimation(name: animationName) else {
            print("animation is nil")
            return
        }
        let trackEntry = animationState.addAnimationByName(trackIndex: Int32(trackIndex), animationName: animationName, loop: loop, delay: 0.0)

        setTrackEntry(trackEntry: trackEntry,reverse: reverse,timeScale: timeScale,isClearEnd: isClearEnd,listener: listener)
    }
    
    //删除轨道
    public func clearTrack(trackIndex: Int32 = 0) {
        animationState.clearTrack(trackIndex: Int32(trackIndex))
        
        //可选：恢复到初始状态（如果需要）通常用于中断当前动画并防止动画混合
//        animationState.setEmptyAnimation(trackIndex: trackIndex, mixDuration: 0)
        
        // 可选：恢复到初始状态
        skeleton?.setToSetupPose()
    }
    
    func setTrackEntry(trackEntry: TrackEntry,
                       reverse: Bool = false,
                       timeScale: Float = 1.0,
                       isClearEnd: Bool = true,
                       listener: AnimationStateListener? = nil) {
        trackEntry.reverse = reverse
        trackEntry.timeScale = timeScale
//        animationStateWrapper.setTrackEntryListener(entry: trackEntry, listener: listener)
        animationStateWrapper.setTrackEntryListener(entry: trackEntry) { type, entry, event in
//            print("\(type.SIEventType.rawValue)")
            listener?(type,entry,event)
            if isClearEnd, type.SIEventType == .COMPLETE {
                self.animationStateWrapper.setTrackEntryListener(entry: trackEntry, listener: nil)
            }
        }
    }
    
    /// 控制朝向 默认
    public func scaleX(faceLeft: Float) {
        skeleton?.scaleX = faceLeft
    }
}

//MARK: - 皮肤
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
    
    var animationState: SIAnimationState {
        controller.animationState
    }
    
    var animationStateWrapper: AnimationStateWrapper {
        controller.animationStateWrapper
    }
}

//MARK:
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

//MARK: - 插槽
extension SkeletonGraphicScript {
    private func configSlots(slots: [Slot]) {
        
        bounds = SkeletonBounds.create()
        
        updateSlotPath()
        
        LogInfo("EEEE")
        //一个带有定点的附件
        //     BoundingBoxAttachment：用于检测与骨骼动画的碰撞和交互，
        //     从Skeleton获取包含`BoundingBoxAttachment`的插槽Slot、
        //     获取顶点数据，
        
        self.slots = slots
        
        //获取边框附件
        
        //        skeleton?.findSlot(slotName: "bianjie")
        
        slots.forEach { slot in
            //            if let name = slot.data.name {
            //                print("slot.name: \(name)")
            //            }
            //插槽的附件
            if let attachment = slot.attachment {
                if attachment.rType == .BOUNDING_BOX {
//                    if let name = attachment.name {
//                        print("attachment.name: \(name)")
//                    }
                    //                    print("attachment.type: \(attachment.type)")
                    //边框
                    //                    if let box = attachment as? BoundingBoxAttachment {
                    //                        print("attachment transform to BoundingBoxAttachment: \(box)")
                    //                    }
                    //                    if let name = slot.data.attachmentName {
                    //                        print("slot.data.attachmentName: \(name)")
                    //                    }
                }
                //                attachment.type
            }
            //查看此插槽位置
            //worldX是世界坐标下的位置，这些坐标相对于Sine Skeleton的原点，而非屏幕和视图坐标
            let position = controller.fromSkeletonCoordinatesToScreen(position: CGPointMake(CGFloat(slot.bone.worldX), CGFloat(slot.bone.worldY)))
            let rect = SlotRect(
                slot: slot,
                rect: CGRect(x: position.x,
                             y: position.y, width: 1, height: 1)
            )
            slotsRect.append(rect)
            
            //            print("slot.position.worldX: \(slot.bone.worldX)、slot.position.worldY: \(slot.bone.worldY)")
            //            print("slot.rect: \(position)")
        }
    }
    
    func getAttachment(slotName: String) {
        
        
    }
}


//MARK: - 碰撞检测
extension SkeletonGraphicScript {
    
    func onTriggerCheck() async {
        
        //更新边界信息
        updateSlotPath()
        
//        print("onTriggerCheck:\(triggerView?.frame):tag:\(triggerView?.tag) count:\(triggerView)")
        // spine对象以及父图层
        // 遍历父图层对象，对内部子对象
        if let spineUIView, let spineSupperview = await spineUIView.superview {
            for v in await spineSupperview.subviews {
                // 排除自身
                if v != spineUIView {
                    await T(v: v, supperview: spineSupperview)
//                    print("v: \(v.subviews.count)")
                    //子视图
                    for v1 in await v.subviews {
                        if v1 != spineUIView {
                            await T(v: v1, supperview: v)
                        }
                    }
//                    print("v: \(v.center)")
                }
            }
        }
    }
    
    func T (v: UIView, supperview: UIView) async {
        let point = await supperview.convert(v.center, to: spineUIView)
//        print("convert: \(point)")
        let rect = await supperview.convert(v.bounds, to: spineUIView)
        //检测
        await MainActor.run {
            //                        if containsPoint(point: point) {
            //                            self.delegate?.onTriggerEnter(other: v)
            //                        }
            
            if let polygon = bounds?.polygons.first {
                if containsPoint(polygon: polygon, point: point) {
                    self.delegate?.onTriggerEnter(other: v)
                }
                
                if containSegment(polygon: polygon,
                                  point1: CGPoint(x: rect.minX, y: rect.minY),
                                  point2: CGPoint(x: rect.maxX, y: rect.maxY)) {
                    self.delegate?.onTriggerEnter(other: v)
                }
            }
        }
    }
    
    func updateSlotPath() {
        if let skeleton {
            //更新边界
            bounds?.update(skeleton: skeleton, updateAabb: true)
        }
        if let polygons = bounds?.polygons {
            onUpdateSlotPath(polygons: polygons)
        }
    }
    
    func onUpdateSlotPath(polygons: [Polygon]) {
        //本次点
        var newboxRect: [CGPoint] = []
        // 确保多边形顶点列表非空
        if let polygon = polygons.first, polygon.vertices.count % 2 == 0 {
            // 将顶点的 x 和 y 值按对组合成一对一对的元组
            let vertices = stride(from: 0, to: polygon.vertices.count, by: 2)
                .compactMap { i -> CGPoint? in
                    // 获取 x 和 y 值，确保安全地获取
                    guard let x = polygon.vertices[i], let y = polygon.vertices[i + 1] else { return nil }
                    let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
                    return controller.fromSkeletonCoordinatesToScreen(position: point)
                }
            // 将所有计算后的位置添加到 boxRect
            newboxRect.append(contentsOf: vertices)
        }

        //记录旧点和新点的变化
        if newboxRect != boxRects {
            boxRects = newboxRect
//            LogInfo("坐标改变了:\(boxRects)")
            delegate?.onUpdatePolygonsTransforms(skeletonGraphicScript: self)
            
            if isDebugPolygons {
                DispatchQueue.main.async {
                    self.debugBoxPoint()
                }
            }
        }
//        LogInfo("boxRect :\(boxRect)")
    }
    
    
    func containsBox(size: CGSize) -> Bool {
//        bounds.con
        return false
    }
    
    func containsPoint(polygon: Polygon, point: CGPoint) -> Bool {
        //转化坐标
        let position = controller.toSkeletonCoordinates(position: point)
        if let b = bounds?.containsPoint(polygon:
                                            polygon, x: Float(position.x), y: Float(position.y)) {
            return b
        }
        return false
    }
    
    //线段
    func containSegment(polygon: Polygon, point1: CGPoint,point2: CGPoint) -> Bool {
//        print("point1:（point1）")
        //转化坐标
        let position1 = controller.toSkeletonCoordinates(position: point1)
        let position2 = controller.toSkeletonCoordinates(position: point2)
        if let b = bounds?.intersectsSegment(polygon: polygon,
                                             x1: Float(position1.x),
                                             y1: Float(position1.y),
                                             x2: Float(position2.x),
                                             y2: Float(position2.y)) {
            return b
        }
        return false
    }
    
    //包含某个点
    func containsPoint(point: CGPoint) -> Bool {
        //转化坐标
        let position = controller.toSkeletonCoordinates(position: point)
        if let b = bounds?.aabbContainsPoint(x: Float(position.x), y: Float(position.y)) {
            return b
        }
        return false
    }
 
    //渲染debug边界区域
    @MainActor public func debugBoxPoint() {
        guard let spineUIView  else {
            print("spineUIView is nil")
            return
        }
        //先移除
        for view in spineUIView.subviews {
            view.removeFromSuperview()
        }
        
        print("debugBoxPoint:\(boxRects)")
        //渲染路径
        for box in boxRects {
            let rView = UILabel()
            rView.frame = CGRect(x: box.x,
                                 y: box.y,
                                 width: 5, height: 5)// boneRect.rect
            rView.backgroundColor = .purple
            spineUIView.addSubview(rView)
        }
    }
}

extension Slot {
    //    public var boxAttachment: BoundingBoxAttachment? {
    //        get {
    //            return spine_slot_get_attachment(wrappee).flatMap { .init($0) }
    //        }
    //        set {
    //            spine_slot_set_attachment(wrappee, newValue?.wrappee)
    //        }
    //    }
}

extension SkeletonBounds {
    
    @discardableResult
    public static func create() -> SkeletonBounds {
        return .init(spine_skeleton_bounds_create())
    }
}

//MARK: - Attachment
extension Attachment {
    
    //    public var aType: UInt32 {
    //        return type.rawValue
    //    }
    
    
    public enum SpineAttachmentType {
        case REGION
        case MESH
        case CLIPPING
        case BOUNDING_BOX
        case PATH
        case POINT
    }
    
    //    具体标号按照`type`对应
    //    typedef enum spine_attachment_type {
    //        SPINE_ATTACHMENT_REGION = 0,// 区域附件（图片区域）
    //        SPINE_ATTACHMENT_MESH, // 网格附件（变形图片）
    //        SPINE_ATTACHMENT_CLIPPING, // 裁剪附件（限制显示区域）
    //        SPINE_ATTACHMENT_BOUNDING_BOX,// 边界框附件（碰撞检测或区域表示）
    //        SPINE_ATTACHMENT_PATH, // 路径附件（用于路径动画）
    //        SPINE_ATTACHMENT_POINT,// 点附件（位置标记）
    //    } spine_attachment_type;
    
    public var rType: SpineAttachmentType {
        switch type.rawValue {
        case 0: .REGION
        case 1: .MESH
        case 2: .CLIPPING
        case 3: .BOUNDING_BOX
        case 4: .PATH
        case 5: .POINT
        default: .REGION
        }
    }
}

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
