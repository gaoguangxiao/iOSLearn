//
//  SkeletonSource.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import Foundation
import SmartCodable
import GGXSwiftExtension

class SkeletonSource: ObservableObject {
    
    @Published
    var datas: [Datum]?
    
    func refresh() {
        Task {
            await loadCharaterJSON()
        }
    }
    
    func loadCharaterJSON() async {
        let data = Bundle.jsonfileTojson("charaterJSON") as? [String: Any]
        if let response = RSResponse.deserialize(from: data) {
            await MainActor.run {
                datas = response.data
            }
        }
    }
    
    @Published
    var medals: [UIImage]?
    
    func loadStonesImages() {
        medals = (0...36).compactMap { UIImage(named: "medal_\($0)") }
    }
}

extension SkeletonSource {
    var npcDatum : Datum? {
        datas?.first
    }
}

struct RSResponse: SmartCodable {
    var data: [Datum]?
}

// 数据源
extension Datum {
    static func spineBoy() -> Datum {
        Datum(json: "spineboy-pro.json",
              atlas: "spineboy-pma.atlas")
    }
    
    static func babuV13() -> Datum {
        Datum(json: "babu_v1.3.json",
              atlas: "babu_v1.3.atlas")
    }
    
    static func babuV13Offline() -> Datum {
        Datum(json: "/web/adventure/spine/babu/babu_v1.3.json",
              atlas: "/web/adventure/spine/babu/babu_v1.3.atlas")
    }
    
    static func npc() -> Datum {
        Datum(json: "character_v1.6.json",
              atlas: "character_v1.6.atlas")
    }
}
