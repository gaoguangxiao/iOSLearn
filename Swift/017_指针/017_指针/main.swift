//
//  main.swift
//  017_指针
//
//  Created by 高广校 on 2023/11/9.
//

import Foundation

print("Hello, World!")

var number = 5
let numberPointer = UnsafePointer<Int>(&number)
print(numberPointer)
