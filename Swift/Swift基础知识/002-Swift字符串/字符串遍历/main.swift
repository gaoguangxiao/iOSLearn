//
//  main.swift
//  字符串遍历
//
//  Created by gaoguangxiao on 2023/3/13.
//

import Foundation

extension String {
    func charAt(i:Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
//    func charAt(i:Int) -> String {
//        return String(self[self.index(self.startIndex, offsetBy: i)])
//    }
//
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
    
    func isAlphanumeric(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlphanumeric()
        }
    }
}


var str = "ABCDEF12"
//print(str.isAlphanumeric(ignoreDiacritics: false))

var strAll = ""
for i in 0..<str.count {
    let s = str.charAt(i: i)
    strAll.append("123")
    strAll.append(s)
}
print(strAll)

