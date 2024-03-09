// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjectable",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
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
