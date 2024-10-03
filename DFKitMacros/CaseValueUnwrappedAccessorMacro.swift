import MacroToolkit
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CaseValueUnwrappedAccessorMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let enumDecl = Enum(declaration) else {
            context.diagnose(Diagnostic(
                node: node,
                message: CaseValueUnwrappedAccessorDiagnostics.notAnEnum
            ))
            return []
        }

        return enumDecl.cases.compactMap { enumCase in
            if let value = enumCase.value, case let .associatedValue(parameters) = value {
                if parameters.count == 1 {
                    let param = parameters.first!
                    return
                        """
                        public var \(raw: enumCase.identifier): \(param.type.asSimpleType!._syntax) {
                            get {
                                guard case let .\(raw: enumCase.identifier)(value) = self else {
                                    fatalError("Failed to access \(raw: enumCase.identifier): not a .\(raw: enumCase.identifier) case")
                                }
                                return value
                            }

                            set {
                                self = .\(raw: enumCase.identifier)(newValue)
                            }
                        }
                        """
                }
            }
            return nil
        }
    }
}

enum CaseValueUnwrappedAccessorDiagnostics: String, DiagnosticMessage {
    var diagnosticID: SwiftDiagnostics.MessageID {
        .init(domain: "CaseVauleAccessor", id: self.rawValue)
    }

    var severity: SwiftDiagnostics.DiagnosticSeverity {
        .error
    }

    case notAnEnum

    var message: String {
        switch self {
        case .notAnEnum:
            return "CaseValueUnwrappedAccessor can only be applied to an enum"
        }
    }
}
