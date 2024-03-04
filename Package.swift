// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Thundering",
    products: [
        .library(
            name: "Thundering",
            targets: ["Thundering"]),
    ],
    targets: [
        .target(
            name: "Thundering"),
        .testTarget(
            name: "ThunderingTests",
            dependencies: ["Thundering"]),
    ]
)
