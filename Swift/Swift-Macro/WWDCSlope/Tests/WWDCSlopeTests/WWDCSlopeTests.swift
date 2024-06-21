import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import WWDCSlopeMacros


let testMacros: [String: Macro.Type] = [
    "EnumSubset" : SlopeSubsetMacro.self,
]

final class WWDCSlopeTests: XCTestCase {
    func testSlopeSubset() {
        assertMacroExpansion(
            """
            @EnumSubset<Slope>
            enum EasySlope {
                case beginnersParadise
                case practiceRun
            }
            """,
            expandedSource: """

            enum EasySlope {
                case beginnersParadise
                case practiceRun
            
                init?(_ slope: Slope) {
                    switch slope {
                    case .beginnersParadise:
                        self = .beginnersParadise
                    case .practiceRun:
                        self = .practiceRun
                    default:
                        return nil
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testSlopeSuberOnStruct() throws {
        assertMacroExpansion(
                """
                @EnumSubset<Slope>
                struct Skier {
                }
                """,
                expandedSource: """

                struct Skier {
                }
                """,
                diagnostics: [
                    DiagnosticSpec(message: "@EnumSubset can only be applied to an enum", line: 1, column: 1)
                ],
                macros: testMacros
            )
    }
    
}
