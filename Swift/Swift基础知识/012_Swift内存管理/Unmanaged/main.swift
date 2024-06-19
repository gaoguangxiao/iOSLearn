//
//  main.swift
//  Unmanaged
//
//  Created by 高广校 on 2023/12/19.
//

import Foundation

print("Hello, World!")

class Foo {
    let x: Int
    init(x: Int) {
        self.x = x
    }
    deinit {
        print("Deinit \(x)")
    }
}

//Unmanaged 非托管
//手动管理内存指针
let fo_0 = Foo(x: 1)
//passRetained(_ value: Instance) -> Unmanaged<Instance> 增加引用计数
//passUnretained(_ value: Instance) -> Unmanaged<Instance> 不增加引用计数
let unmanaged = Unmanaged.passUnretained(fo_0)

//返回该实例中swift管理的引用，而不减少引用次数，可以按照get对待其返回值
//let fo_00 = unmanaged.takeUnretainedValue()
//print(fo_00.x)

let fo_00 = unmanaged.takeRetainedValue()
//print(fo_00.x)
//打印托管对象引用计数
print(CFGetRetainCount(fo_00))

//需要调用者 负责对象的释放
let fo_01 = unmanaged.takeRetainedValue()
//打印托管对象引用计数
print(CFGetRetainCount(fo_01))

unmanaged.release()
//print(CFGetRetainCount(unmanaged.takeUnretainedValue()))
//print(CFGetRetainCount(unmanaged.takeRetainedValue()))
//自动销毁
//_ = Unmanaged.passUnretained(Foo(x: 1))

let str = ""

