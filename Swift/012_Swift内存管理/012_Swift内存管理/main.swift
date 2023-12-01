//
//  main.swift
//  012_Swift内存管理
//
//  Created by gaoguangxiao on 2023/3/12.
// 理解内存计数 weak 循环引用 无主引用

import Foundation

print("Hello, World!")

class Test {
    var name:String
//    var ref:Test?
    weak var ref:Test?
//    unowned var ref:Test?
    
//    lazy var data:()->Void = {[unowned self]() -> Void  in
//        print("姓名：" + self.name)
//    }
    
    //lazy  弱引用和无主引用  闭包
    lazy var data:()->Void = {[weak self]() -> Void  in
        print("姓名：" + self!.name)
    }
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Test deinit" + self.name)
    }
}

func test03()  {
    let t  = Test(name: "A")
    
    t.data()
}

test03()

func test01() {
    //开辟 Test堆空间
    //和oc的引用计数一样，没有任何指向，引用计数为0，会被系统销毁，release方法
    var t:Test? = Test(name: "A")
    
    let t1:Test? = Test(name: "B")
    //t 指向这个内存空间
//    var t1 = t
    t?.ref = t1
    t1?.ref = t
    
    t = nil
    
    //无主引用 不会将引用指针为空
    t1?.ref?.name = "B"
    
    //print(t?.name)
}


func test02() {

    let t  = Test(name: "A")
    
    let t1 = Test(name: "B")
    
    t.ref = t1
    
    t1.ref = t
    
}

//test01()
//test02()

//let size = MemoryLayout.size(ofValue: Int)     //实际占用的内存空间
//let stride = MemoryLayout.stride(ofValue: Double) //分配的内存空间
//let alignment = MemoryLayout.alignment(ofValue: psw)
////pswSize: 33
//print("size:",size)
//print("stride:",stride)
//print("alignment:",alignment)
