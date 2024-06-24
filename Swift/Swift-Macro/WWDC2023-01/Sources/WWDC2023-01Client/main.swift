import WWDC2023_01

//@DictionaryStorage
//enum Gender {
//}

@DictionaryStorage
struct Person {
}

let p = Person(dictionary: ["key":"name"])

print("The value \(p.dictionary)")
