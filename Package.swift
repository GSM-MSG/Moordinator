// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Moordinator",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Moordinator",
            targets: ["Moordinator"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Moordinator",
            dependencies: []
        ),
        .testTarget(
            name: "MoordinatorTests",
            dependencies: ["Moordinator"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
