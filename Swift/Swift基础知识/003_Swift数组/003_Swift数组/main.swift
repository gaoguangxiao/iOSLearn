//
//  main.swift
//  003_Swift数组
//
//  Created by gaoguangxiao on 2023/3/11.
//

import Foundation

print("Hello, World!")

//https://www.jianshu.com/p/984102e89eba

var arr1 = [7]

var arr = [1,3,5,6,2,4,7,2]
//arr.map { $0 * 2 }
//print(arr3)

let opS: String = "1"
var arr2 = ["A","B","C",opS]
//let arr4 = arr2.flatMap { str in
//    return Int(str)
//}

//compactMap 转换然后解包
let arr5 = arr2.compactMap { str in
    return Int(str)
}
//["A1", "B1", "C1"]
print("arr5: \(arr5)")

//获取集合最后一个元素
let index = arr.index(before: arr.endIndex)
let item =  arr[index]
//print(item)

//let item =  arr[arr.count-1]
print(item)

//var arr1 = arr
//print(arr[0])
//arr[0] = 100
//print(arr[0])
//print(arr1[0])

//排序
//arr.sort { a, b in
//    return a < b
//}
//print(arr)

//筛选、过滤
//let arr1 = arr.filter { a in
//    return a != 2
//}
//print(arr1)

//得到两数组重复元素
//let arr2 = arr1.filter { arr.contains($0)}
//print(arr2)

//找最大和最小
//let arr2 = arr.max { a, b in
//    return a < b
//}
//let arr2 = arr.max { return $0 < $1}
//print(arr2 ?? 0)
//
////arr.map { a in  a * 2 }

//var arr = [1,3,5,6,2,4,7,2]



//var array = ["hello","World","swift"]
//数组追加
//array+=["java"]
//print(array)
//array.insert("php", at: 0)
//print(array)

//array.remove(at: 1)

////修改
//array[0] = "web"
//array.replaceSubrange((0...1), with: ["python"])
//print(array)
////查
//print(array.contains("hello"))


//var a = [1,2,3,4]
//print(a)
//变量 变量名字:[数据类型]
//var b:[String] = ["A","B"]
//print("\(b)")
//var c:Array<String> = ["C","D"]
//print(c)
//var d = Array<String>()
//d.append("E")
//print(d)
//var e = [String]()
//e.append("F")
//print(e)

//定义长度为3 初始化为-1的数组
//var f = Array(repeating: -1, count: 3)
//print(f)
//f[0] = 100
//print(f)


//MARK：使用一个数组对另一个数组初始化
//let arr2 = Array(arrayLiteral: arr)
//print(arr2)

