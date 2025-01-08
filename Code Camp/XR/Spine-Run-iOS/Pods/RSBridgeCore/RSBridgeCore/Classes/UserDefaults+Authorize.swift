//
//  UserDefaults+Authorize.swift
//  RSBridgeAuthorize
//
//  Created by 高广校 on 2024/12/10.
//

import Foundation
import GGXSwiftExtension

public extension Keys {
    //麦克风权限
    static let record = "record"
}

public extension UserDefaults {
    @UserDefaultWrapper(key: Keys.record, defaultValue: false)
    static var record: Bool
}
