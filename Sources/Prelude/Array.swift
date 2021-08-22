// Copyright © Fleuronic LLC. All rights reserved.

public extension Array {
	func chunked(intoSize size: Int) -> [[Element]] {
		return stride(from: 0, to: count, by: size).map {
			Array(self[$0..<Swift.min($0 + size, count)])
		}
	}
}
