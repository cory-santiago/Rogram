// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// Package containing the networking APIs for Rogram
let package = Package(
    name: "RogramAPI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RogramAPI",
            targets: ["RogramAPI"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RogramAPI",
            resources: [.process("MockMainFeedResponse")]),
        .testTarget(
            name: "RogramAPITests",
            dependencies: ["RogramAPI"],
            resources: [.process("MockMainFeedResponse")]),
    ]
)
/*
 targets: [
     .target(
         name: "MyLibrary",
         resources: [
             .process("text.txt")]
     ),
 ]
 */
