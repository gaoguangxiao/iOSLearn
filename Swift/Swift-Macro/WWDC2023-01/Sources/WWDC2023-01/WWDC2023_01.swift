// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@attached(member, names: named(dictionary), named(init(dictionary:)))
//@attached(memberAttribute)
//@attached(accessor)
public macro DictionaryStorage(key: String? = nil) = #externalMacro(module: "WWDC2023_01Macros", type: "DictionaryStorageMacro")
