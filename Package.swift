// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "DFKit",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DFKit",
            targets: ["DFKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
        .package(url: "https://github.com/stackotter/swift-macro-toolkit.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DFKit",
            dependencies: ["DFKitCoreGraphics", "DFKitSwiftUI", "DFKitEasing", "DFKitMacros"],
            path: "DFKit"
        ),
        .macro(
            name: "DFKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
            ],
            path: "DFKitMacros"
        ),
        .executableTarget(
            name: "DFKitMacrosClient",
            dependencies: ["DFKit"],
            path: "DFKitMacrosClient"
        ),
        .target(
            name: "DFKitCoreGraphics",
            path: "DFKitCoreGraphics"
        ),
        .target(
            name: "DFKitEasing",
            path: "DFKitEasing"
        ),
        .target(
            name: "DFKitSwiftUI",
            dependencies: ["DFKitCoreGraphics"],
            path: "DFKitSwiftUI"
        ),
        .testTarget(
            name: "DFKitTests",
            dependencies: [
                "DFKitMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
