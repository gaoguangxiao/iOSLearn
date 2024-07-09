//
//  main.swift
//  Range
//
//  Created by 高广校 on 2024/6/25.
//

import Foundation
import AppKit

print("Hello, World!")

//#TODO: ClosedRange

//###
///let range = 0...10
///
///print("range.first is: \(range.first!)") //0
///
///print("range.last is: \(range.last!)") //10
//let arr = [1,3,5,6,2,4,7,2]
//for index in 0..<arr.count {
//    print("arr \(index) is \(arr[index])")
//}

// #TODO: CountableRange

let names1 = ["Antoine", "Maaike", "Jaap"]
let range1 = 0...1
let seq = names1[range1]
print("1 is \(names1[range1])") // 1 is ["Antoine", "Maaike"]
print("2 is \(names1[0...1])") // 2 is ["Antoine", "Maaike"]

//print("3 is \(names1[0...4])") // 2 is ["Antoine", "Maaike"]

print("4 is \(names1[...2])") // 4 is ["Antoine", "Maaike", "Jaap"]

print("5 is \(names1[1...])") // 5 is ["Maaike", "Jaap"]

///必须指定结束，否则会无限循环
var collectedNames: [String] = []
//for index in 0... {
//    print("arr \(index)")
//    collectedNames.append("\(index)")
//}

for index in 0... {
    guard index < names1.count else { break }
    collectedNames.append("\(index)")
}
print("collectedNames is: \(collectedNames)") //collectedNames is: ["0", "1", "2"]

let title = "A Swift Blog"
let range = title.range(of: "Swift")!

let convertedRange = NSRange(range, in: title)
let attributedString = NSMutableAttributedString(string: title)
attributedString.setAttributes([NSAttributedString.Key.foregroundColor: NSColor.orange], range: convertedRange)
print(attributedString)


//let attributedString = NSMutableAttributedString(string: title)
//attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], range: range)
// Cannot convert value of type 'Range<String.Index>?' to expected argument type 'NSRange' (aka '_NSRange')
