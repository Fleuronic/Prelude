// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONSerialization {
	static func jsonObject(with data: Data) throws -> Any {
		try jsonObject(with: data, options: [])
	}
}
