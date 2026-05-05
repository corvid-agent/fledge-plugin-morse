// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "fledge-plugin-morse",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "fledge-plugin-morse",
            path: "Sources"
        )
    ]
)
