//
//  RSConfigiOSModel.swift
//  RSReading
//
//  Created by 高广校 on 2024/1/10.
//

import Foundation
import GXSwiftNetwork
import SmartCodable

public class RSConfigiOSBaseModel: MSBApiModel {
    var ydata: RSConfigiOSModel? {
        return RSConfigiOSModel.deserialize(from: data as? Dictionary<String, Any>)
    }
}

// MARK: - RSConfigiOSModel
public class RSConfigiOSModel: SmartCodable {
    public var osWakeTime: Double?
    public var iosVersion: IosVersion?
    public var phEnable: Bool?
    public var manifest: MainFest?
    public var osUriWhiteList: [String] = []
    required public init(){}
}

// MARK: - IosVersion
public class IosVersion: SmartCodable {
    required public init(){}
    
    public var downloadUrl: String?
    public var latest: String?
    public var min: String?
    public var phVersion: String?
    public var releaseNote: String?
    public var title: String?
}

// MARK: - MainFest
public class MainFest: SmartCodable {
    required public init(){}
    public var contentManifest: String?
    public var enableCache: Bool?
    public var initialManifest, initialUrl: String?
    public var paths: Paths?
    public var spineManifest, staticManifest: String?
}

// MARK: - Paths
public class Paths: SmartCodable {
    required public init(){}
    var audPath, cdnPath, resPath, wwwPath: String?
}

