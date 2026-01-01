// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AllScreenshotsSDK",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "AllScreenshotsSDK",
            targets: ["AllScreenshotsSDK"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AllScreenshotsSDK",
            dependencies: [],
            path: "Sources/AllScreenshotsSDK"
        ),
        .testTarget(
            name: "AllScreenshotsSDKTests",
            dependencies: ["AllScreenshotsSDK"],
            path: "Tests/AllScreenshotsSDKTests"
        ),
        .testTarget(
            name: "IntegrationTests",
            dependencies: ["AllScreenshotsSDK"],
            path: "Tests/IntegrationTests"
        )
    ]
)
