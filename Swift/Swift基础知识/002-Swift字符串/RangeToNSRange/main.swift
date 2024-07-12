//
//  main.swift
//  RangeToNSRange
//
//  Created by 高广校 on 2024/7/11.
//

import Foundation
var str = "感谢您下载并使用XXX！我们非常重视您的个人信息和隐私保护。请您在使用我们服务前，仔细阅读并充分理解《用户协议》、《隐私政策》尤其是相关协议中以粗体标识的条款。如您同意，请点击“同意”后接受我们的服务。"

extension String {
    func nsRange(_ searchString: String) -> NSRange {
        if let range = self.range(of: searchString, options: .caseInsensitive) {
            let nsrange = NSRange(range, in: self)
            return nsrange
        }
        return NSRange(location: 0, length: 0)
    }
}

print("Hello, World!")

let startIndex = str.startIndex
let searchStr = "《用户协议》"
print("startIndex：\(startIndex)")
if let range: Range = str.range(of: searchStr) {
    let nrange1 = NSRange(range, in: str)
    print("nrange1: \(nrange1)")
}

let nrange2 = str.nsRange(searchStr)
print("nrange2: \(nrange2)")
