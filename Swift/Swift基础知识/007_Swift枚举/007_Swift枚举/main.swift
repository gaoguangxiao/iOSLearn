//
//  main.swift
//  007_Swift枚举
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

frozenTest()

class A {
    func log() {
        
    }
}

class B {
    
}

//enum TestEnum {
//    case A
//    case B
//    case C
//}

enum TestEnum {
    case A, B, C , Other
    
    func playT(e:TestEnum) {
        print(e)
    }
}

enum TestNum1:Int {
    case spring = 2,summer,autumn,winter
}

enum TestNum2:String {
    case spring = "春天",summer,autumn,winter
}

let size = MemoryLayout<TestNum1>.size
print("TestNum1 size：",size)


enum TestNum3:CaseIterable {
    case spring ,summer,autumn,winter
}

enum TestNum4 : Any {
    case spring(A),summer(B)
}

func test(e:TestEnum) {
    switch e {
    case .A:
        print("A")
        fallthrough
    case .B:
        print("B")
        
    case .C:
        print("C")
    default:
        break
        
    }
}

enum ActionType {
    enum Audio {
        case up
    }
    case AudioPlaya
    case Video
}

enum AudioType : String , CaseIterable{
    case playa,pausea,stopa
}

enum VideoType : String , CaseIterable{
    case playv,pausev,stopv
}

// audio 播放 暂停 audiocalss
// viode 播放 暂停 videocalss

var jMap : Dictionary<String,String> = [:]
for v in AudioType.allCases {
    jMap[v.rawValue] = "AudioCalss"
//    print(v)
}

for v in VideoType.allCases {
    jMap[v.rawValue] = "Videocalss"
//    print(v)
}

print(jMap)

func testDate() {
    //示例代码日历
    enum SDate {
        case digit(year:Int,month:Int,day:Int)
        case string(String)
    }
    var date = SDate.digit(year: 2023, month: 9, day: 19)
    date = .string("2023-9-19")
    switch date {
    case .digit(let year, let month , let day):
        print(year,month,day)
    case let .string(value):
        print(value)
    }
}

func testPassword() {
    enum Password {
        case number(Int,Int,Int,Int)
        case gesture(String)
    }
    
//    var psw = Password.number(1, 2, 3, 4)
    var psw = Password.gesture("1")
    
    switch psw {
    case let .number(n1, n2, n3, n4):
        print(n1,n2,n3,n4)
    case let .gesture(str):
        print(str)
    }
    
    let size = MemoryLayout.size(ofValue: psw)     //实际占用的内存空间
    let stride = MemoryLayout.stride(ofValue: psw) //分配的内存空间
    let alignment = MemoryLayout.alignment(ofValue: psw)
    //pswSize: 33
    print("size:",size)
    print("stride:",stride)
    print("alignment:",alignment)
}
testPassword()

func testIndirect (){
    //自己引用自己
    indirect enum ArithExpr {
        case number(Int)
        case sum(ArithExpr,ArithExpr)
        case difference(ArithExpr,ArithExpr)
    }

    var ari = ArithExpr.number(10)
    var ari2 = ArithExpr.number(20)

    ari = .sum(ari, ari2)
    ari = .difference(ari, ari2)

    func calulate(expr:ArithExpr) -> Int{
        switch expr {
        case let .number(value):
            return value
        case let .sum(a, b):
            return calulate(expr: a) + calulate(expr: b)
        case let .difference(a, b):
            return calulate(expr: a) - calulate(expr: b)
        }
    }

    let valur = calulate(expr: ari)
    print(valur)
}

func testMemoryLayout(){
    //使用MemoryLayout获取数据类型所占内存大小
    var age = 10
    let size = MemoryLayout<Int>.size //打印8,8个字节
    let stride = MemoryLayout<Int>.stride
    let alignment = MemoryLayout<Int>.alignment
    print("size:",size)
    print("stride:",stride)
    print("alignment:",alignment)
}



//test(e: .A)
//TestEnum.A.playT(e: .B)
//print(TestEnum.B)
//打印实际的数值

//var nA = [String:Any].self

//nA[TestNum4.summer.] = A()

//TestNum4.spring(<#T##A#>)

//print(TestNum2.spring)
//print(TestNum2.spring.rawValue)

//for v in TestNum3.allCases {
//    print(v)
//}

//print(TestNum3.allCases.count)
//TestNum3.AllCases
