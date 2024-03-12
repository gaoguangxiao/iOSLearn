//
//  Setting.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import Foundation

enum Setting {
    case pepleOcclusion
    case objectOcclusion
    case lidarDebug
    case multiuser
    
    var label: String {
        get {
            switch self {
            case .pepleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .lidarDebug:
                return "LidarDebug"
            case .multiuser:
                return "Multiuser"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .pepleOcclusion:
                return "person"
            case .objectOcclusion:
                return "cube.box.fill"
            case .lidarDebug:
                return "light.min"
            case .multiuser:
                return "person.2"
            }
        }
    }
}
