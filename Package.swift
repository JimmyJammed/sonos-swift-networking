// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SonosNetworking",
    platforms: [.iOS(.v14),
                .macOS(.v10_12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SonosNetworking",
            targets: ["SonosNetworking"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.1")),
        .package(url: "https://github.com/WeTransfer/Mocker.git", .upToNextMajor(from: "2.5.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SonosNetworking",
            dependencies: [
                "Alamofire"
            ]),
        .testTarget(
            name: "SonosNetworkingTests",
            dependencies: [
                "SonosNetworking",
                "Mocker"
            ]),
    ]
)
