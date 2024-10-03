import DFKitMacros
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

private let testMacros: [String: Macro.Type] = [
    "CustomBackgroundViewExtension": CustomBackgroundViewExtensionMacro.self,
]

final class CustomBackgroundViewExtensionMacroTests: XCTestCase {
    func testMacro() throws {
        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension("nodeBackground", "nodeBackgroundKeyPath")
            """,
            expandedSource:
            """
            extension View {
                func nodeBackground(_ style: CustomBackground) -> some View {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.nodeBackgroundKeyPath, style)
                }
                func nodeBackground<S>(_ style: S) -> some View where S: ShapeStyle {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.nodeBackgroundKeyPath, style)
                }
                func nodeBackground<V>(alignment: Alignment = .center, _ content: () -> V) -> some View where V: View {
                    CustomBackgroundModifier.customBackground(forView: self, keyPath: \\.nodeBackgroundKeyPath, alignment: alignment, content)
                }
            }
            extension EnvironmentValues {
                @Entry var nodeBackgroundKeyPath: CustomBackground = .none
            }
            """,
            macros: testMacros
        )
    }

    func testMacroTooFewArgumentsDiagnostic() throws {
        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension(nodeBackground)
            """,
            expandedSource:
            """
            """,
            diagnostics: [
                .init(
                    message: "Not enough arguments",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )

        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension()
            """,
            expandedSource:
            """
            """,
            diagnostics: [
                .init(
                    message: "Not enough arguments",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )
    }

    func testMacroTooManyArgumentsDiagnostic() throws {
        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension("nodeBackground", "style", "other")
            """,
            expandedSource:
            """
            """,
            diagnostics: [
                .init(
                    message: "Too many arguments",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )
    }

    func testMacroArgumentNotStringLiteral() throws {
        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension(20, "nodeBackgroundKeyPath")
            """,
            expandedSource:
            """
            """,
            diagnostics: [
                .init(
                    message: "Expected a string literal",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )
        assertMacroExpansion(
            """
            #CustomBackgroundViewExtension("nodeBackground", 20)
            """,
            expandedSource:
            """
            """,
            diagnostics: [
                .init(
                    message: "Expected a string literal",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )
    }
}
