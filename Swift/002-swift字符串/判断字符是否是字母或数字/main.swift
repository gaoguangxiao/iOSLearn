//
//  main.swift
//  判断字符是否是字母或数字
//
//  Created by gaoguangxiao on 2023/3/13.
//

import Foundation

//判断字符 是字母或数字
func isLetterOrDigital(_ string:String) ->Bool{
    let numberRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[0-9]+.*$")
    let letterRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[A-Za-z]+.*$")
    if numberRegex.evaluate(with: string) || letterRegex.evaluate(with: string) {
        return true
    }else{
        return false
    }
}

//判断字符 是字母和数字
func isLetterWithDigital(_ string:String) ->Bool{
    let numberRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[0-9]+.*$")
    let letterRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[A-Za-z]+.*$")
    if numberRegex.evaluate(with: string) || letterRegex.evaluate(with: string) {
        return true
    }else{
        return false
    }
}


print(isLetterWithDigital("D"))
print(isLetterOrDigital("`"))
