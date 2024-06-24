// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
/// 该宏为独立宏，以#开头
@freestanding(expression) // 指定当前宏实一个表达角色的独立宏，#externalMacro是Swift内置的宏，指定当前宏对应的模块名以及类型标示,指定编译器应该启动的插件，以及插件中类型的名称，启动一个叫WWDC2023Macros的插件，并要求一个名为StringifyMacro的类型展开它
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "WWDC2023Macros", type: "StringifyMacro")
