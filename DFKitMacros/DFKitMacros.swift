import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct DFKitMacros: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CaseValueUnwrappedAccessorMacro.self,
        CustomBackgroundViewExtensionMacro.self,
    ]
}
