//
//  main.swift
//  015.1泛型进阶
//
//  Created by 高广校 on 2024/6/21.
//

import Foundation

print("Hello, World!")

// Swif5.9 泛型系统通过对参数长度进行 泛型抽象
struct Request<Result> {
    let result: Result
}

// 类型参数集合 type paragra
// 概念为：参数聚合的泛型化API
struct RequestEvaluator {
    //单个
//    func evaluate(_ request: Request<Bool>) -> Bool {
//        return RequestEvaluator().evaluate(request)
//    }
      
    //可以处理所有参数的长度，没有人为限制
    func evaluate<each Result>(_: repeat Request<each Result>) -> (repeat each Result) {
//        Result
        
//        return Request(result: results)
    }
}

let requestEvaluator = RequestEvaluator()

let r1 = Request(result: 1)
let r2 = Request(result: true)
let r3 = Request(result: "Hello")

let results = requestEvaluator.evaluate(r1,r2,r3)
print(results)
