// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "example",
    platforms: [.macOS(.v14)],
    products: [
        .executable(
            name: "example",
            targets: ["example"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing", exact: "0.13.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "example",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
