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
            @CustomBackgroundViewExtension("nodeBackground", "nodeBackgroundKeyPath")
            public extension View {}
            """,
            expandedSource:
            """
            public extension View {

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
            """,
            macros: testMacros
        )
    }

    func testMacroTooFewArgumentsDiagnostic() throws {
        assertMacroExpansion(
            """
            @CustomBackgroundViewExtension
            public extension View {}
            """,
            expandedSource:
            """
            public extension View {}
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
            @CustomBackgroundViewExtension("nodeBackground")
            public extension View {}
            """,
            expandedSource:
            """
            public extension View {}
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

    // test too many args
    func testMacroTooManyArgumentsDiagnostic() throws {
        assertMacroExpansion(
            """
            @CustomBackgroundViewExtension("nodeBackground", "nodeBackgroundKeyPath", "extra")
            public extension View {}
            """,
            expandedSource:
            """
            public extension View {}
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

    // test non-string args
    func testMacroExpectedStringLiteralDiagnostic() throws {
        assertMacroExpansion(
            """
            @CustomBackgroundViewExtension(nodeBackground, nodeBackgroundKeyPath)
            public extension View {}
            """,
            expandedSource:
            """
            public extension View {}
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
