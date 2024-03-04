// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Thundering",
    products: [
        .library(
            name: "Thundering",
            targets: ["Thundering"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "Thundering"),
        .testTarget(
            name: "ThunderingTests",
            dependencies: ["Thundering"])
    ]
)
