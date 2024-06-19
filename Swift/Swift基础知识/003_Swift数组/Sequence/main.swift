//
//  main.swift
//  Sequence
//
//  Created by 高广校 on 2023/12/15.
//

import Foundation

//创建遵循`IteratorProtocol`协议的结构体`InfiniteIterator`

struct InfiniteIterator: IteratorProtocol {
    let value: Int
    
    func next() -> Int? {
        return value
    }
    
}
 
struct InfiniteSequence: Sequence {
    let value: Int
    
    func makeIterator() -> some IteratorProtocol {
        return InfiniteIterator(value: value)
    }
}


print("Hello, World!")

let infinite = InfiniteSequence(value: 24)

let prefix = infinite.prefix(10)
print(prefix)

for value in infinite.prefix(10) {
    print(value)
}

//for...in内部实现
//本质通过Collection创建一个迭代器`Iterator`，然后把当前数组传给迭代器
