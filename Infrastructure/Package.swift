// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Infrastructure",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WatchlistInfrastructure",
            targets: ["WatchlistInfrastructure"]),
        .library(
            name: "Environment",
            targets: ["Environment"]),
    ],
    dependencies: [
        .package(name: "Coordinators", path: "../Coordinators"),
        .package(name: "Domain", path: "../Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WatchlistInfrastructure",
            dependencies: [.product(name: "WatchlistDomain", package: "Domain"), "Environment"]),
        .target(
            name: "Environment",
            dependencies: []),
        .testTarget(
            name: "InfrastructureTests",
            dependencies: ["WatchlistInfrastructure"]),
    ]
)
