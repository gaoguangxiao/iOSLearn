//
//  main.swift
//  RangeLocation
//
//  Created by 高广校 on 2024/7/19.
//

import Foundation

print("Hello, World!")

let PUBLIC_KEY = """
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdklK4kIsOMuxTZ8jG1PRPfXqSDmaCIQ+xEpIRSssQ6jiuvhYZTMUbV22osgtivuyKdnHm+cvzGuZCSB8QFyCcM7l09HZVs0blLkrBAU5CVSv+6BzPQTVJytoi/VO4mlf6me1Y9bXWrrPw1YtC1mnB2Ix9cuaxOLpucglfGbUaGEigsUZMTD2vuEODN5cJi39ap+G9ILitbrnt+zsW9354pokVnHw4Oq837Fd7ZtP0nAA5F6nE3FNDGQqLy2WYRoKC9clDecD8T933azUD98b5FSUGzIhwiuqHHeylfVbevbBW91Tvg9s7vUMr0Y2YDpEmPAf0q4PlDt8QsjctT9kQIDAQAB
-----END PUBLIC KEY-----
"""


func addPublicKey(_ key: String) -> String? {
    var newKey = key
    let spos = newKey.range(of: "-----BEGIN PUBLIC KEY-----")
    let epos = newKey.range(of: "-----END PUBLIC KEY-----")
    if let s = spos?.upperBound , let e = epos?.lowerBound {
        newKey = String(newKey[s..<e])
    }
    newKey = newKey.replacingOccurrences(of: "\r", with: "")
    newKey = newKey.replacingOccurrences(of: "\n", with: "")
    newKey = newKey.replacingOccurrences(of: "\t", with: "")
    newKey = newKey.replacingOccurrences(of: " ", with: "")
    return newKey
}


let newKey = addPublicKey(PUBLIC_KEY)
print(newKey)
