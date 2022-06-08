// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "compress-pdf",
    products: [
        .executable(name: "compress-pdf", targets: ["compress-pdf"]),
        .library(name: "PDFCompressor", targets: ["PDFCompressor"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "compress-pdf",
            dependencies: [
                "PDFCompressor",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "PDFCompressor",
            dependencies: []),
        .testTarget(
            name: "PDFCompressorTests",
            dependencies: ["PDFCompressor"]),
    ]
)
