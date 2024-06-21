// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Defines a subset of the `Slope` enum
///
/// Generates two members:
///  - An initializer that converts a `Slope` to this type if the slope is
///    declared in this subset, otherwise returns `nil`
///  - A computed property `slope` to convert this type to a `Slope`
///
/// - Important: All enum cases declared in this macro must also exist in the
///              `Slope` enum.
/// WWDCSlopeMacros 名称来自
@attached(member, names: named(init))
public macro EnumSubset<Subperset>() = #externalMacro(module: "WWDCSlopeMacros", type: "SlopeSubsetMacro")
