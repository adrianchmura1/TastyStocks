// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Watchlist",
            targets: ["Watchlist"]),
    ],
    dependencies: [
        .package(name: "Coordinators", path: "../Coordinators"),
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Infrastructure", path: "../Infrastructure"),
        .package(name: "SnapKit", url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "Watchlist",
            dependencies: [
                .product(name: "WatchlistDomain", package: "Domain"),
                .product(name: "WatchlistInfrastructure", package: "Infrastructure"),
                .product(name: "Coordinators", package: "Coordinators"),
                "SnapKit"
            ]),
        .testTarget(
            name: "AppTests",
            dependencies: ["Watchlist"]),
    ]
)
