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
