//
//  SessionSettings.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnable: Bool = false
    @Published var isObjectOcclusionEnable: Bool = false
    @Published var isLidarDebugEnable: Bool = false
    @Published var isMultiuserEnable: Bool = false
}
