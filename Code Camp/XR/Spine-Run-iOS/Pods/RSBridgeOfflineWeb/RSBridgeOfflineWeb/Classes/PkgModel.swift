//
//  RSPkgModel.swift
//  PkgModel
//
//  Created by 高广校 on 2023/12/26.
//

import Foundation
import SmartCodable

public class PkgModel: SmartCodable {
    /// 资源类型，必须
    var type: String?
    
    /// 资源 id，必须
    var item: String?

    /// 指定客户端下发下载进度的 action name，如未指定则不下发进度 "progressAction": "string",
    var progressAction: String?
    
    /// 客户端和指定键名的本地缓存进行关联，可选，默认为 content_manifest 的 url
    var cacheKey: String?
    
    /// 离线包任务优先级
    /// * "default"：优先级介于 high 和 low 之间，不设定优先级的默认值
    /// * "high"：高优先级
    /// * "low"：低优先级
    /// * "idle"：闲时下载
    var priority: String?
    
//    folderName
    
    /// 资源包下目录 pkg、preset
    var folderName: String?
    
    required public init() {}
}
