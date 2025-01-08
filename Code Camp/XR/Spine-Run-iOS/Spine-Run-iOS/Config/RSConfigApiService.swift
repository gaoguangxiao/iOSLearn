//
//  RSConfigApiService.swift
//  RSReading
//
//  Created by 高广校 on 2024/1/10.
//

import Foundation
import GXSwiftNetwork
//import RSBridgeOfflineWeb

class ConfigApi: MSBApi {
    
    class LaunchApi: ConfigApi{
//        override init(paras : [String: Any]) {
//            super.init(path:"/wap/api/certificate/tencent",paras: paras)
//        }
        init(paras : [String: Any]) {
            super.init(path: "wap/api/config/ios",
                       parameters: paras,showErrorMsg: false,showHud: false)
        }
    }
    
    
    
//    class certificateApi: ConfigApi{
//        init(paras : [String: Any]) {
//            super.init(path:"/wap/api/certificate/tencent",
//                       parameters: paras,showErrorMsg: false,showHud: false)
//        }
//    }
    
}

public class RSConfigApiService {
    
    public static let share = RSConfigApiService()
    //MARK: 获取配置
    
    public func configsiOS(params: [String: Any],closure: @escaping ((RSConfigiOSBaseModel?) -> ())) {
        let api = ConfigApi.LaunchApi(paras: params)
        api.request { (result: RSConfigiOSBaseModel?) in
            closure(result)
        } onFailure: { _ in
            closure(nil)
        }
    }
    
}
