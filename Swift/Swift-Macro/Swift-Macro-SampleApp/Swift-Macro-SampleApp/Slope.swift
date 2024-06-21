//
//  Slope.swift
//  Swift-Macro-SampleApp
//
//  Created by 高广校 on 2024/6/20.
//

import Foundation

#if canImport(WWDCSlope)
import WWDCSlope
#endif

/// 我最喜欢的滑雪胜地的斜坡。
enum Slope {
    case beginnersParadise
    case practiceRun
    case livingRoom
    case olympicRun
    case blackBeauty
}

/// 适合初学者的斜坡。“斜率”的子集。
#if canImport(WWDCSlope)
@SlopeSubset
enum EasySlope {
    case beginnersParadise
    case practiceRun
}
#else
enum EasySlope {
    case beginnersParadise
    case practiceRun
    init?(_ slope: Slope) {
        switch slope {
        case .beginnersParadise: self = .beginnersParadise
        case .practiceRun: self = .practiceRun
        default: return nil
        }
    }
    
    var slope: Slope {
        switch self {
        case .beginnersParadise: return .beginnersParadise
        case .practiceRun: return .practiceRun
        }
    }
}
#endif
