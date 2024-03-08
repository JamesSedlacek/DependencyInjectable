// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjectable",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .macCatalyst(.v17)
    ],
    products: [
        .library(
            name: "DependencyInjectable",
            targets: ["DependencyInjectable"]),
    ],
    targets: [
        .target(
            name: "DependencyInjectable"),
        .testTarget(
            name: "DependencyInjectableTests",
            dependencies: ["DependencyInjectable"]),
    ]
)
