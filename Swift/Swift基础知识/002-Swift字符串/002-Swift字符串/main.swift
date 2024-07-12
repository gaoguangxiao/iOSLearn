//
//  main.swift
//  002-swift字符串
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

var str = "ABCDEF"

var value = """
ABCDEFG
  ABCDEFG
                ABCDEFG
"""

//打印特殊字符
value =  #""ABCDE""#
print(value)

//##`startIndex`
/*
 字符或代码单元在字符串中的位置。
 @frozen public struct Index : Sendable {
 }
 **/
//let oIndex = str.index(str.startIndex, offsetBy: 2)


//字符串遍历
//for s in  str {
//    print("\(s)")
//}
//
//for i in 0..<str.count {
//    let s = str[str.index(str.startIndex, offsetBy: i)]
//    print(s)
//}

//字符串格式化
let value122 = 2.012

//CVarArg 是Swift对C相关api的封装
let strValue = String(format: "第%.2f次", value122)
//print(strValue)

//print(str.contains("A"))

//str
//print(str.contains(where: String.contains("AL")))

//print(str.hasPrefix("A"))

//字符串替换
//let si = str.index(str.startIndex, offsetBy: 2)
//let se = str.index(str.startIndex, offsetBy: 3)
//str.replaceSubrange(si...se, with: "RR")
//print(str)

//将某字符替换
//str.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)

//1、输出
//print("输出str：\(str)")
//2、打印长度
//print("字符串str长度：\(str.count)")

//print(str.endIndex)

//str[] []里面需要的是string.index类型
//str.index(before: str.endIndex) 返回 string.index
//3、打印最后一个字
//let eIndex = str.index(before: str.endIndex)
//print(str[eIndex])

//4、打印指定偏移
let oIndex = str.index(str.startIndex, offsetBy: 2)
let o1Index = str.index(str.startIndex, offsetBy: 4)
////0..2 区间语法
print(str[oIndex..<o1Index])

//5、
//print(str.prefix(4))

//6、查找某个字符出现的位置
//var index = str.firstIndex(of: "E") ?? str.endIndex
//print(str[index])

//print(str[str.index(after: str.startIndex)])
