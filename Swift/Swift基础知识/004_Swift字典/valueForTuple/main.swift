//
//  main.swift
//  valueForTuple
//
//  Created by 高广校 on 2024/7/12.
//

import Foundation

print("Hello, World!")

struct SModel {
    
    var name: String?
}

let sm = SModel()

var sm1 = SModel()
sm1.name = "G"
let sm2 = SModel()

//1、快捷定义
var dict = ["A": (sm, 1), "B":(sm1, 2),"C":(sm2, 3)]
print(dict)

let flStr = "B"
//筛查B
let newD = dict.filter { dicts in
    dicts.key == flStr
}
print(newD)
//n
let newA = dict.filter { (key,value) in
    key == flStr
}
print(newA)

//
if let (m,a) = dict.filter { $0.key == flStr }.first?.value {
    print((m,a))
}
