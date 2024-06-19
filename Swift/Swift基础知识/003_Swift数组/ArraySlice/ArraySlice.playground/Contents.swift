import Cocoa

var greeting = "Hello, playground"

//print("Hello, World!")

//ArraySlice 数组片段
let aSlice: ArraySlice = ArraySlice<Any>()

//定义一个包含整型数据的数组
var arr: Array = [120, 130, 140, 150, 160]
//使用ArraySlice进行截取
let arrSlice = arr[1...3]

//打印`arrSlice`的类型
print("type(of:arrSlice):\(type(of: arrSlice))") // ArraySlice<Int>

//打印`arrSlice`的值
print("arrSlice:\(arrSlice)")

let arrSlicedrop = arrSlice.dropFirst() //ArraySlice<Int>.SubSequece
//arr.dropFirst()
print(arrSlicedrop)

let numbers = [1, 2, 3, 4, 5]
//print(numbers.dropFirst(2))
// Prints "[3, 4, 5]"
// print(numbers.dropFirst(10))
//     Prints "[]"
