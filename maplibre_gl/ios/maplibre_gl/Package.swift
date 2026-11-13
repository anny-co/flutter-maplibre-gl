// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "maplibre_gl",
    platforms: [
        .iOS("15.0"),
    ],
    products: [
        .library(name: "maplibre-gl", targets: ["maplibre_gl"])
    ],
    targets: [
        .target(
            name: "maplibre_gl",
            dependencies: ["MapLibre"]
        ),
        // anny's MapLibre Native build with symbol-height-offset (see ../../../native/README.md); also in
        // maplibre_gl.podspec
        .binaryTarget(name: "MapLibre", path: "MapLibre.xcframework"),
    ]
)
