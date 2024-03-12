//
//  ModelCategory.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/23.
//

import Foundation
import UIKit
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    case cartoon
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chair"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            case .cartoon:
                return "Cartoon"
            }
        }
    }
}


class Model {
    
    var name: String
    
    var category: ModelCategory
    
    var thumbnail: UIImage
    
    var modelEntity: ModelEntity?
    
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModeEntity() {
        
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink { loadCompletion in
                switch loadCompletion {
                case .failure(let error):
                    print("Unable to load modelEntity for\(filename).Error:\(error.localizedDescription)")
                    
                case .finished:
                    break
                }
            } receiveValue: { modelEntity in
            
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                 
                print("modelEntity for \(filename) has been loaded.")
            }

    }
}

struct Models {
    
    var all: [Model] = []
    
    init() {
        
        // Tables
        let dinnigTable = Model(name: "dining_table", category: .table, scaleCompensation: 0.32/100)
//        let famityTable = Model(name: "dining_table", category: .table, scaleCompensation: 0.32/100)
//        
        self.all += [dinnigTable]
        
        // Chairs
        let dinnigChair = Model(name: "dining_chair", category: .chair, scaleCompensation: 0.32/100)
        let redchair = Model(name: "redchair", category: .chair, scaleCompensation: 0.32/100)
//        let eamesChairWhite = Model(name: "eames_chair_white", category: .chair, scaleCompensation: 0.32/100)
//        let eamesChairWoodgrain = Model(name: "eames_chair_woodgrain", category: .chair, scaleCompensation: 0.32/100)
//        let eamesChairBlackLeather = Model(name: "eames_chair_black_leather", category: .chair, scaleCompensation: 0.32/100)
//        let eamesChairBrownLeather = Model(name: "eames_chair_brown_leather", category: .chair, scaleCompensation: 0.32/100)

        self.all += [redchair,dinnigChair]
        
        // Decor
        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor)
        let teaPot = Model(name: "teapot", category: .decor)
        let wateringcan = Model(name: "wateringcan", category: .decor)
//        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor)
//        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor)
//        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor, scaleCompensation: 0.32/100)
        self.all += [cupSaucerSet,teaPot,wateringcan]
        
        // peplr
        let vintagerobot2k = Model(name: "vintagerobot2k", category: .cartoon)
        let drummertoy = Model(name: "drummertoy", category: .cartoon,scaleCompensation: 2)
        
        
        self.all += [vintagerobot2k,drummertoy]
    }
    
    func get(category: ModelCategory) -> [Model]? {
        return all.filter( {$0.category == category})
    }
}
