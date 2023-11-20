//
//  main.swift
//  016_可选项
//
//  Created by 高广校 on 2023/9/20.
//

import Foundation

print("Hello, World!")

//字符串转int
var num = Int("ABC1234")
if num != nil {
    print(num)
} else {
    print("无数据nil")
}

//可选项绑定
if let n = num {
    print(n)
} else {
    print("无数据nil")
}

