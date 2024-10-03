import DFKitMacros
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

private let testMacros: [String: Macro.Type] = [
    "CaseValueUnwrappedAccessor": CaseValueUnwrappedAccessorMacro.self,
]

final class CaseValueAccessorMacroTests: XCTestCase {
    func testMacro() throws {
        assertMacroExpansion(
            """
            @CaseValueUnwrappedAccessor
            enum Value {
                case int(Int)
                case double(Double)
                case string(String)
            }
            """,
            expandedSource:
            """
            enum Value {
                case int(Int)
                case double(Double)
                case string(String)

                public var int: Int {
                    get {
                        guard case let .int(value) = self else {
                            fatalError("Failed to access int: not a .int case")
                        }
                        return value
                    }

                    set {
                        self = .int(newValue)
                    }
                }

                public var double: Double {
                    get {
                        guard case let .double(value) = self else {
                            fatalError("Failed to access double: not a .double case")
                        }
                        return value
                    }

                    set {
                        self = .double(newValue)
                    }
                }

                public var string: String {
                    get {
                        guard case let .string(value) = self else {
                            fatalError("Failed to access string: not a .string case")
                        }
                        return value
                    }

                    set {
                        self = .string(newValue)
                    }
                }
            }
            """,
            macros: testMacros
        )
    }

    func testNoAssociatedValues() throws {
        assertMacroExpansion(
            """
            @CaseValueUnwrappedAccessor
            enum Value {
                case int
                case double
                case string
            }
            """,
            expandedSource:
            """
            enum Value {
                case int
                case double
                case string
            }
            """,
            macros: testMacros
        )
    }

    func testNotAnEnum() throws {
        assertMacroExpansion(
            """
            @CaseValueUnwrappedAccessor
            struct Value {
                var int: Int
                var double: Double
                var string: String
            }
            """,
            expandedSource:
            """
            struct Value {
                var int: Int
                var double: Double
                var string: String
            }
            """,
            diagnostics: [
                .init(
                    message: "CaseValueUnwrappedAccessor can only be applied to an enum",
                    line: 1,
                    column: 1
                ),
            ],
            macros: testMacros
        )
    }
}
