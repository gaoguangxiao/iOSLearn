//
//  ReplaceHandyJSON_1ViewController.swift
//  SmartCodable_Example
//
//  Created by qixin on 2024/3/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SmartCodable
import HandyJSON

class ReplaceHandyJSON_1ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dict: [String: Any] = [
            "name": "Mccc",
            "age":12
        ]

        guard let handyModel = HandyModel.deserialize(from: dict) else { return }
        let toDict = handyModel.toJSON()
        let toJsonStr = handyModel.toJSONString()
        
        print("handyModel: \(handyModel)")
        
        guard let smartModel = SmartModel.deserialize(from: dict) else { return }
        let toDict1 = smartModel.toDictionary()
        let toJsonStr1 = smartModel.toJSONString()
        print("smartModel: \(smartModel)")
        
        guard let handyModels = [HandyModel].deserialize(from: [dict]) as? [HandyModel] else { return }
        let toArr = handyModels.toJSON()
        let toArrStr = handyModels.toJSONString()
        
        guard let smartModels = [SmartModel].deserialize(from: [dict]) else { return }
        let toArr1 = smartModels.toArray()
        let toArrStr1 = smartModels.toJSONString()
    }
}

extension ReplaceHandyJSON_1ViewController {
    class HandyModel: HandyJSON {
        var name: String = ""
        required init() { }
    }
    
    class SmartModel: SmartCodable {
        var name: String = ""
        required init() { }
    }
}



