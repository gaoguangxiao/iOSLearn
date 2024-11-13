//
//  SkeletonSource.swift
//  Spine-iOS
//
//  Created by 高广校 on 2024/11/12.
//

import Foundation
import SmartCodable

class SkeletonSource: ObservableObject {
    
    @Published
    var datas: [Datum]?
    
    func loadCharaterJSON() {
        
        let data = Bundle.jsonfileTojson("charaterJSON") as? [String: Any]
        if let response = RSResponse.deserialize(from: data) {
            Task.detached { [self] in
                await MainActor.run {
                    datas = response.data
                }
            }
        }
    }
}

struct RSResponse: SmartCodable {
    var data: [Datum]?
}

struct Datum: SmartCodable, Identifiable {
    
    var id: Int?
    var name: String?
    var json, atlas: String?
    var atlasURL, jsonURL: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case json = "JSON"
        case atlas = "Atlas"
        case atlasURL = "AtlasURL"
        case jsonURL = "JSONURL"
    }
}
