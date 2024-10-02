// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftToolKit",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftToolKit",
            targets: ["SwiftToolKit"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftToolKit",
            dependencies: ["CGExtensions", "SwiftUIExtensions", "Easing"]
        ),
        .target(name: "CGExtensions", path: "Sources/CGExtensions"),
        .target(name: "Easing", path: "Sources/Easing"),
        .target(name: "SwiftUIExtensions", dependencies: ["CGExtensions"], path: "Sources/SwiftUIExtensions"),
        .testTarget(
            name: "swift-toolkitTests",
            dependencies: ["SwiftToolKit"]
        ),
    ]
)
