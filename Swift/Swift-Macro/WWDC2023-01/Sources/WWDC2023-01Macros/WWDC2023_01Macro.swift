import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

/// 定义该模块可以生成的所有诊断信息
/// DiagnosticMessage一种协议，拥有一些列属性提供诊断信息
enum MyLibDiagnostic: String, DiagnosticMessage {
    // a case for each error or warning you can emit
    case onlyApplicableToStuct
    
    /// Is this an error or a waring
    var severity: DiagnosticSeverity {
        return .error
    }
    
    /// Error message
    var message: String {
        switch self {
        case .onlyApplicableToStuct:
            return "@DictionaryStorage can only be applied to an struct"
        }
    }
    
    /// Unique errror code user modudel name with domain
    var diagnosticID: MessageID {
        MessageID(domain: "MyLibMacros", id: rawValue)
    }
}

/// Implementation of the `DictionaryStorageMacro` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
//declaration 遵守DeclGroupSyntax一个类型，枚举，结构体
public struct DictionaryStorageMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext)
    throws -> [DeclSyntax] {
        guard declaration.is(StructDeclSyntax.self) else {
            let structError = Diagnostic(
                node: node,
                message: MyLibDiagnostic.onlyApplicableToStuct
            )
            context.diagnose(structError)
            return []
        }
        return [
            "init(dictionary: [String: Any]) { self.dictionary = dictionary }",
            "var dictionary: [String: Any]"
        ]
    }
}

@main
struct WWDC2023_01Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DictionaryStorageMacro.self,
    ]
}
