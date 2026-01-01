// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "AllscreenshotsDemo",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(path: "../sdk")
    ],
    targets: [
        .executableTarget(
            name: "AllscreenshotsDemo",
            dependencies: [
                .product(name: "AllScreenshotsSDK", package: "sdk")
            ],
            path: "AllscreenshotsDemo"
        )
    ]
)
