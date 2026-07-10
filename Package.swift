// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Fasty",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(url: "https://github.com/Lakr233/libghostty-spm.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "CBridge",
            path: "Sources/CBridge",
            publicHeadersPath: "include"
        ),
        .executableTarget(
            name: "Fasty",
            dependencies: [
                "CBridge",
                .product(name: "GhosttyTerminal", package: "libghostty-spm"),
            ],
            path: "Sources/Fasty",
            linkerSettings: [
                .linkedFramework("Cocoa"),
                .linkedFramework("Carbon"),
                .linkedFramework("CoreText"),
                .linkedFramework("Metal"),
                .linkedFramework("MetalKit"),
                .linkedFramework("QuartzCore"),
            ]
        ),
    ]
)
