// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "zyphy",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macCatalyst(.v13),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Tokenizer", targets: ["Tokenizer"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", "509.0.0"..<"601.0.0"),
        .package(url: "https://github.com/apple/swift-testing", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: "Tokenizer",
            dependencies: [
                "TokenizerMacros",
                "HTMLEntities",
            ],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=100"], .when(configuration: .debug)),
                .unsafeFlags(["-Xfrontend", "-warn-long-expression-type-checking=100"], .when(configuration: .debug)),
                .enableExperimentalFeature("CodeItemMacros"),
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
        .macro(
            name: "TokenizerMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=100"], .when(configuration: .debug)),
                .unsafeFlags(["-Xfrontend", "-warn-long-expression-type-checking=100"], .when(configuration: .debug)),
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
        .target(
            name: "HTMLEntities",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny")
            ]
        ),
        .testTarget(
            name: "TokenizerTests",
            dependencies: [
                "TokenizerMacros",
                "Tokenizer",
                .product(name: "Testing", package: "swift-testing"),
            ],
            exclude: [
                "Resources/html5lib-tests/encoding",
                "Resources/html5lib-tests/lint_lib",
                "Resources/html5lib-tests/serializer",
                "Resources/html5lib-tests/tokenizer/README.md",
                "Resources/html5lib-tests/tokenizer/unicodeCharsProblematic.test",
                "Resources/html5lib-tests/tokenizer/xmlViolation.test",
                "Resources/html5lib-tests/tree-construction",
                "Resources/html5lib-tests/AUTHORS.rst",
                "Resources/html5lib-tests/LICENSE",
                "Resources/html5lib-tests/lint",
                "Resources/html5lib-tests/pyproject.toml",
            ],
            resources: [
                .process("Resources/html5lib-tests/tokenizer/test1.test"),
                .process("Resources/html5lib-tests/tokenizer/test2.test"),
                .process("Resources/html5lib-tests/tokenizer/test3.test"),
                .process("Resources/html5lib-tests/tokenizer/test4.test"),
                .process("Resources/html5lib-tests/tokenizer/unicodeChars.test"),
                .process("Resources/html5lib-tests/tokenizer/entities.test"),
                .process("Resources/html5lib-tests/tokenizer/namedEntities.test"),
                .process("Resources/html5lib-tests/tokenizer/numericEntities.test"),
                .process("Resources/html5lib-tests/tokenizer/pendingSpecChanges.test"),
                .process("Resources/html5lib-tests/tokenizer/contentModelFlags.test"),
                .process("Resources/html5lib-tests/tokenizer/escapeFlag.test"),
                .process("Resources/html5lib-tests/tokenizer/domjs.test"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny")
            ]
        ),
        .testTarget(
            name: "HTMLEntitiesTests",
            dependencies: [
                "HTMLEntities",
                .product(name: "Testing", package: "swift-testing"),
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny")
            ]
        ),
    ],
    swiftLanguageVersions: [.version("6")]
)
