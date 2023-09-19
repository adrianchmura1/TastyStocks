// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Watchlist",
            targets: ["Watchlist"]),
    ],
    dependencies: [
        .package(.Domain),
        .package(.DependencyInjection),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Watchlist",
            dependencies: []),
        .testTarget(
            name: "AppTests",
            dependencies: ["Watchlist"]),
    ]
)

enum Targets: String {
    case Watchlist
}

enum Dependencies: String {
    case Coordinators
    case Resolver

    func dependency() -> Target.Dependency {
        switch self {
        case .Coordinators:
            return Target.Dependency(self)

        case .Resolver:
            return Target.Dependency(self, package: .DependencyInjection)
        }
    }
}

enum Packages: String {
    case Domain
    case DependencyInjection
}

extension Target {
    static func target(name: Targets,
                       dependencies: [Dependencies] = [],
                       resources: [Resource]? = nil) -> Target {
        .target(name: name.rawValue,
                dependencies: dependencies.map { $0.dependency() },
                path: "Sources/\(name)",
                resources: resources)
    }

    static func testTarget(name: Targets,
                           dependencies: [Dependencies] = [],
                           resources: [Resource]? = nil) -> Target {
        .testTarget(name: name.rawValue,
                    dependencies: dependencies.map { $0.dependency() },
                    path: "Tests/\(name)",
                    resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: Dependencies) {
        self.init(stringLiteral: target.rawValue)
    }

    init(_ target: Dependencies, package: Packages) {
        self = Self.product(name: target.rawValue, package: package.rawValue)
    }
}

extension Product {
    static func library(target: Targets) -> PackageDescription.Product {
        library(name: target.rawValue, targets: [target.rawValue])
    }

    static func library(target: Targets, targets: [Targets]) -> PackageDescription.Product {
        library(name: target.rawValue, targets: targets.map { $0.rawValue })
    }
}

extension Package.Dependency {
    static func package(_ package: Packages) -> Package.Dependency {
        Self.package(name: package.rawValue, path: "../\(package.rawValue)")
    }
}
