import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum SlopeSubsetError: CustomStringConvertible, Error {
    case onlyApplicableToEnum
    
    var description: String {
        switch self {
        case .onlyApplicableToEnum: return "@EnumSubset can only be applied to an enum"
        }
    }
}
/// Implementation of the `EnumSubset` macro.
public struct SlopeSubsetMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext)
    throws -> [DeclSyntax] {
        guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
            throw SlopeSubsetError.onlyApplicableToEnum
        }
        
        guard let supersetType = node
            .attributeName.as(IdentifierTypeSyntax.self)?
            .genericArgumentClause?
            .arguments.first?
            .argument else {
            // TODO: Handle error
            return []
        }
        
        let members = enumDecl.memberBlock.members
        let caseDecls = members.compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
        let elements = caseDecls.flatMap { $0.elements }
        
        let initializer = try InitializerDeclSyntax("init?(_ slope: \(supersetType)) ") {
            try SwitchExprSyntax("switch slope") {
                for element in elements {
                    SwitchCaseSyntax(
                        """
                        case .\(element.name):
                            self = .\(element.name)
                        """
                    )
                }
                SwitchCaseSyntax("default: return nil")
            }
        }
        //        return []
        return [DeclSyntax(initializer)]
    }
}

@main
struct WWDCSlopePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SlopeSubsetMacro .self,
    ]
}
