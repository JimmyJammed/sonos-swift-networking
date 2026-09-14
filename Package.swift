// swift-tools-version: 6.3
import PackageDescription
let package = Package(
    name: "SonosNetworking",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [.library(name: "SonosNetworking", targets: ["SonosNetworking"]),
               .executable(name: "sonos-networking-demo", targets: ["NetworkingDemo"])],
    targets: [.target(name: "SonosNetworking"),
              .executableTarget(name: "NetworkingDemo", dependencies: ["SonosNetworking"]),
              .testTarget(name: "SonosNetworkingTests", dependencies: ["SonosNetworking"])],
    swiftLanguageModes: [.v6]
)
