// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TheGameApodini",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "TheGameApodini", targets: ["TheGameApodini"])
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("feature/oas-tags"))
    ],
    targets: [
        .target(
            name: "TheGameApodini",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .target(name: "TheGameApodiniLibrary")
            ]
        ),
        .target(
            name: "TheGameApodiniLibrary",
            dependencies: [
                .product(name: "Apodini", package: "Apodini")
            ]
        ),
        .testTarget(
            name: "TheGameApodiniTests",
            dependencies: [
                .target(name: "TheGameApodini")
            ]
        ),
        .testTarget(
            name: "TheGameApodiniLibraryTests",
            dependencies: [
                .target(name: "TheGameApodiniLibrary")
            ]
        )
    ]
)
