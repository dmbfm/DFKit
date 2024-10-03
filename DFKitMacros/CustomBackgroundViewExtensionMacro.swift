import MacroToolkit
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CustomBackgroundViewExtensionMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        if node.arguments.count < 2 {
            context.diagnose(Diagnostic(
                node: node,
                message: CustomBackgroundViewExtension.notEnoughArguments
            ))
            return []
        }

        if node.arguments.count > 2 {
            context.diagnose(Diagnostic(
                node: node,
                message: CustomBackgroundViewExtension.tooManyArguments
            ))
            return []
        }

        let firstArg = node.arguments.first!.expression
        let secondArg = node.arguments.dropFirst().first!.expression

        guard let funcName = StringLiteral(firstArg)?.value, let keyPath = StringLiteral(secondArg)?.value else {
            context.diagnose(Diagnostic(
                node: node,
                message: CustomBackgroundViewExtension.expectedStringLiteral
            ))
            return []
        }

        return [
            """
            extension View {
                func \(raw: funcName)(_ style: CustomBackground) -> some View {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.\(raw: keyPath), style)
                }
                func \(raw: funcName)<S>(_ style: S) -> some View where S: ShapeStyle {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.\(raw: keyPath), style)
                }
                func \(raw: funcName)<V>(alignment: Alignment = .center, _ content: () -> V) -> some View where V: View {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.\(raw: keyPath), alignment: alignment, content)
                }
            }
            extension EnvironmentValues {
                @Entry var \(raw: keyPath): CustomBackground = .none
            }
            """,
        ]
    }
}

enum CustomBackgroundViewExtension: String, DiagnosticMessage {
    var diagnosticID: SwiftDiagnostics.MessageID {
        .init(domain: "CustomBackgroundViewExtension", id: self.rawValue)
    }

    var severity: SwiftDiagnostics.DiagnosticSeverity {
        .error
    }

    case notEnoughArguments
    case tooManyArguments
    case expectedStringLiteral

    var message: String {
        switch self {
        case .notEnoughArguments:
            return "Not enough arguments"
        case .tooManyArguments:
            return "Too many arguments"
        case .expectedStringLiteral:
            return "Expected a string literal"
        }
    }
}
