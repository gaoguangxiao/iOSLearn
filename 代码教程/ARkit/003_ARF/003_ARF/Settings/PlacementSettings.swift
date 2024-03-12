//
//  PlacementSettings.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/23.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    @Published var selectedModel: Model? {
        
        willSet(newValue) {
            
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
            
            self.recentlyPlaced.append(model)
        }
    }
    
    // this property retains a record of placed models in scene. The lase element in the array is the most recently placed model.
    @Published var recentlyPlaced: [Model] = []
    
    // This property retains the cancelable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
    
}
