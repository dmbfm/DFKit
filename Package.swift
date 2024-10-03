// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DFKit",
            dependencies: ["CGExtensions", "SwiftUIExtensions", "Easing"],
            path: "DFKit"
        ),
        .target(name: "CGExtensions", path: "CGExtensions"),
        .target(name: "Easing", path: "Easing"),
        .target(name: "SwiftUIExtensions", dependencies: ["CGExtensions"], path: "SwiftUIExtensions"),
        .testTarget(
            name: "DFKitTests",
            dependencies: ["DFKit"]
        ),
    ]
)
