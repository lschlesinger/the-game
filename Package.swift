// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheGameApodini",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("develop"))
    ],
    targets: [
        .target(
            name: "TheGameApodini",
            dependencies: [
                .product(name: "Apodini", package: "Apodini")
            ]),
        .testTarget(
            name: "TheGameApodiniTests",
            dependencies: ["TheGameApodini"])
    ]
)
