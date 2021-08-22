// swift-tools-version:5.3
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Prelude",
	products: [
		.library(
			name: "Prelude",
			targets: ["Prelude"]
		)
	],
	targets: [
		.target(
			name: "Prelude",
			dependencies: []
		),
		.testTarget(
			name: "PreludeTests",
			dependencies: ["Prelude"]
		)
	]
)
