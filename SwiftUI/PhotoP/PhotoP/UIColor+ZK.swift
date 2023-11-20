//
//  UIColor+ZK.swift
//  ZKNASProj
//
//  Created by 董建伟 on 2022/10/21.
//

import Foundation
import UIKit

public extension UIColor {
    
    /// hex 初始化 color  ex: UIColor.zkColor("333333") 兼容 333333 和 #333333两种格式
    class func zkColor(_ hex: String, alpha: CGFloat = 1) -> UIColor{
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        if #available(iOS 13.0, *) {
            scanner.currentIndex = scanner.string.startIndex
        }
        else{
            scanner.scanLocation = 0
        }

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return UIColor(red: CGFloat(r) / 0xff,
                       green: CGFloat(g) / 0xff,
                       blue: CGFloat(b) / 0xff,
                       alpha: alpha)
    }

    
    class var zk333333: UIColor {
        get {
            return .zkColor("#333333")
        }
    }
    
    class var zk3179E5: UIColor {
        get {
            return .zkColor("#3179E5")
        }
    }
    
    class var zk999999: UIColor {
        get {
            return .zkColor("#999999")
        }
    }
    
    class var zkCCCCCC: UIColor {
        get {
            return .zkColor("#CCCCCC")
        }
    }
    
    class var zkF7F8FA: UIColor {
        get {
            return .zkColor("#F7F8FA")
        }
    }
    class var zkD9EAFF: UIColor {
        get {
            return .zkColor("#D9EAFF")
        }
    }
    class var zkE0E0E0: UIColor {
        get {
            return .zkColor("#E0E0E0")
        }
    }
    
    class var zkFAFAFA: UIColor {
        get {
            return .zkColor("#FAFAFA")
        }
    }

    class var zk000000: UIColor {
        get {
            return .zkColor("#000000")
        }
    }
    
    class var zk666666: UIColor {
        get {
            return .zkColor("#666666")
        }
    }
    
    class var zk1CD18B: UIColor {
        get {
            return .zkColor("#1CD18B")
        }
    }
    
    class var zkEBEBEB: UIColor {
        get {
            return .zkColor("#EBEBEB")
        }
    }
    
    
    
    
    
    
}

