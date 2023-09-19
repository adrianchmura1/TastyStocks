// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    products: [
        .library(
            name: "Resolver",
            targets: ["Resolver"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", from: "2.8.3"),
    ],
    targets: [
        .target(
            name: "Resolver",
            dependencies: ["SwinjectAutoregistration"]
        ),
    ]
)
