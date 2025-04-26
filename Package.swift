// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteModule",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FavoriteModule",
            targets: ["FavoriteModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/diki-haryadi/GGameCatalogCoreModule.git", branch: "main")
    ],
    targets: [
        .target(
            name: "FavoriteModule",
            dependencies: [
                .product(name: "CoreModule", package: "CoreModule")
            ]),
        .testTarget(
            name: "FavoriteModuleTests",
            dependencies: ["FavoriteModule"]),
    ]
)
