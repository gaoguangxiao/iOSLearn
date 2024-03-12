//
//  CustomARView.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/23.
//

import RealityKit
import ARKit
import FocusEntity
import Combine

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    
    var sessionSettings: SessionSettings
    
    var peopleOcclusionCancellable: Cancellable?
    var objectOcclusionCancellable: Cancellable?
    var lidarDebugCancellable: Cancellable?
    var multiuserCancellable: Cancellable?

    required init(frame frameRect: CGRect, sessionSettings: SessionSettings)  {
        
        self.sessionSettings = sessionSettings
     
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
           
        configure()
        
        initializeSettings()
        
        setupSubscribers()
    }
    
//    required init(frame frameRect: CGRect)  {
//        super.init(frame: frameRect)
//        
//        focusEntity = FocusEntity(on: self, focus: .classic)
//           
//        configure()
//    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func configure()  {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        session.run(config)
    }
    
    
    private func initializeSettings() {
        self.updatePeopleOcclusion(isEnable: sessionSettings.isPeopleOcclusionEnable)
        self.updateObjectOcclusion(isEnable: sessionSettings.isObjectOcclusionEnable)
        self.updateLidarDebug(isEnable: sessionSettings.isLidarDebugEnable)
        self.updateMultiuser(isEnable: sessionSettings.isMultiuserEnable)
    }
    
    private func setupSubscribers() {
        self.peopleOcclusionCancellable = sessionSettings.$isPeopleOcclusionEnable.sink(receiveValue: { [weak self] isEnable in
            self?.updatePeopleOcclusion(isEnable: isEnable)
        })
        
        self.objectOcclusionCancellable = sessionSettings.$isObjectOcclusionEnable.sink(receiveValue: { [weak self] isEnable in
            self?.updateObjectOcclusion (isEnable: isEnable)
        })
        
        self.lidarDebugCancellable = sessionSettings.$isLidarDebugEnable.sink(receiveValue: { [weak self] isEnable in
            self?.updateLidarDebug(isEnable: isEnable)
        })
        
        self.multiuserCancellable = sessionSettings.$isMultiuserEnable.sink(receiveValue: { [weak self] isEnable in
            self?.updateMultiuser(isEnable: isEnable)
        })
    }
    
    func updatePeopleOcclusion(isEnable: Bool) {
        print("\(#file): isPeopleOcclusionEnable is now \(isEnable)")
        
        // is supports FrameSemantics
        // personSegmentationWithDepth：带有深度信息的人形分离
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            return
        }
        
        guard let configuration = self.session.configuration as? ARWorldTrackingConfiguration else { return }
        
        // 人形分离
        if configuration.frameSemantics.contains(.personSegmentationWithDepth) {
            configuration.frameSemantics.remove(.personSegmentationWithDepth)
        } else {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        self.session.run(configuration)
    }
    
    func updateObjectOcclusion(isEnable: Bool) {
        print("\(#file): isObjectOcclusionEnable is now \(isEnable)")
        
        // 场景理解
        if self.environment.sceneUnderstanding.options.contains(.occlusion) {
            self.environment.sceneUnderstanding.options.remove(.occlusion)
        } else {
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        }
    }
    
    func updateLidarDebug(isEnable: Bool) {
        print("\(#file): isLidarDebugEnable is now \(isEnable)")
        
        if self.debugOptions.contains(.showSceneUnderstanding) {
            self.debugOptions.remove(.showSceneUnderstanding)
        } else {
            self.debugOptions.insert(.showSceneUnderstanding)
        }
    }
    
    func updateMultiuser(isEnable: Bool) {
        print("\(#file): isMultiuserEnable is now \(isEnable)")
    }
}
