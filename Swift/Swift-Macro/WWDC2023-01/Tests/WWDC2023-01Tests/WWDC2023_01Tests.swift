import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(WWDC2023_01Macros)
import WWDC2023_01Macros

let testMacros: [String: Macro.Type] = [
    "stringify": DictionaryStorageMacro.self,
]
#endif

final class WWDC2023_01Tests: XCTestCase {
    func testMacro() throws {
#if canImport(WWDC2023_01Macros)
        assertMacroExpansion(
            """
            @DictionaryStorage
            struct Person {
            }
            """,
            expandedSource: """
            struct Person {
                init(dictionary: [String: Any]) { self.dictionary = dictionary }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testMacroWithStringLiteral() throws {
#if canImport(WWDC2023_01Macros)
        assertMacroExpansion(
            #"""
            #stringify("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
