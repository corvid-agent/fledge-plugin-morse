// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "fledge-plugin-morse",
    platforms: [.macOS(.v13)],
    targets: [
        .target(name: "MorseLib", path: "Sources/MorseLib"),
        .executableTarget(name: "fledge-morse", dependencies: ["MorseLib"], path: "Sources", exclude: ["MorseLib"]),
        .testTarget(name: "MorseTests", dependencies: ["MorseLib"], path: "Tests"),
    ]
)
