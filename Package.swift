// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CTPicker",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "CTPicker",
            targets: ["CTPicker"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CTPicker",
            dependencies: []),
    ]
)
