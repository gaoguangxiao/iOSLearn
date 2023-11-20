//
//  ViewController.swift
//  frozen
//
//  Created by 高广校 on 2023/11/10.
//

import UIKit

//默认枚举需要增加`@unknown default`匹配位置情况，如`UIUserInterfaceStyle`枚举类,代表以后可能会增加新的枚举值，这样匹配使用的时候需要添加
/**
 @available(iOS 12.0, *)
 public enum UIUserInterfaceStyle : Int, @unchecked Sendable {

     
     case unspecified = 0

     case light = 1

     case dark = 2
 }
 
 if #available(iOS 12.0, *) {
     let style: UIUserInterfaceStyle = .light

     switch style {
     case .light:
         print("light")
         break
     case .dark:
         print("dark")
         break
     case .unspecified:
         print("unspecified")
     @unknown default:
         fatalError()
     }
 }
 */

/***`@available` 表示函数，类等类型的生命周期

 平台有 iOS、macOS、watchOS、tvOS、*（代表所有平台）
 introduced：版本号
 deprecated：弃用版本
 message：信息
 例子：@available(iOS, introduced: 13.0, deprecated: 10000, message: "")
 
 
 */
//

@available(iOS, introduced: 9.0, deprecated: 13, message: "User Test")
public enum Season : Int , @unchecked Sendable {
    case spring = 1,summer,autumn,winter
}

@available(iOS,introduced: 15.0)
public let iOSPRO = 10

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        iOSPRO
        
        if #available(iOS 12.0, *) {
            let style: UIUserInterfaceStyle = .light

            switch style {
            case .light:
                print("light")
                break
            case .dark:
                print("dark")
                break
            case .unspecified:
                print("unspecified")
//            @unknown default:
//                fatalError()
            }
        }
        
        frozenTest()
    }

    func frozenTest()  {
        let season : Season = .spring
        
        switch season {
        case .spring:
            print("春天")
        case .summer:
            print("夏天")
        case .autumn:
            print("秋天")
        case .winter:
            print("冬天")
        }
        
    }


}

