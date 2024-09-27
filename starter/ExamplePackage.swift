// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "your-tool",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "your-tool",
            targets: ["your-tool"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.5.0", owner: "Martin"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.13.0", owner: "Alex")
    ],
    targets: [
        .executableTarget(
            name: "your-tool",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        )
    ]
)

extension PackageDescription.Package.Dependency {
    static func package(
        url: String,
        exact version: Version,
        owner: String
    ) -> PackageDescription.Package.Dependency {
        .package(url: url, exact: version)
    }
}
