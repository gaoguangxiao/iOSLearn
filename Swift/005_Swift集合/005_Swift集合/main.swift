//
//  main.swift
//  005_Swift集合
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

//var a = [1,4,5,6]
//var b:Set<Int> = [2,4,6,8]
//print(b)

var c:Set<String> = ["A","B","C"]

var q = c.filter { $0 != "B"}
print(q)

//c.insert("D")
//c.remove("B")
//c.remove(at: c.startIndex)

//集合运算
//var d:Set<String> = ["B","D"]
//var e = c.union(d)//集合合并 返回新的集合
//print("合集：\(e)")
//
//var f = c.subtracting(d)//返回c
//print("返回交集c的补集\(f)")
//
//var g = c.intersection(d)
//print("交集：\(g)")



