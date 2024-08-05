//
//  main.swift
//  004_Swift字典
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

//1、快捷定义
var dict = ["A":1,"B":2,"C":3]
//2、定义
//var dict1:Dictionary<String,Any> = [:]
//var dic2:[String:Int] = [:]

//print(dict["A"] ?? "unknowm")

var dict3 = dict.filter { (k, v) in
    return v == 2
}

print(dict3)
