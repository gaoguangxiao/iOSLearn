import WWDC2023

let a = 17
let b = 25

//宏的调用
//宏展开，右键 Expand Macro
let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")
