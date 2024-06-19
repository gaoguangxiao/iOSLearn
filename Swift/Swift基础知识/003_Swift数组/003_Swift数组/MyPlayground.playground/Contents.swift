import Cocoa

var greeting = "Hello, playground"

let absences = [0, 2, 0, 4, 0, 3, 1, 0]

let midpoint = absences.count / 2
let firstHalf = absences[..<midpoint]
let secondHalf = absences[midpoint...]

let firstHalfSum = firstHalf.reduce(0, +)
