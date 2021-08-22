// Copyright © Fleuronic LLC. All rights reserved.

public extension Collection where Index: BinaryInteger {
	subscript(safeIndex index: Int) -> Element? {
		guard index < endIndex else { return nil }
		return index >= 0 ? self[Index(index)] : self[safeIndex: count + index]
	}
}
