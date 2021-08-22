// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension String {
	func text(extractedFrom regex: NSRegularExpression) -> String? {
		let range = NSRange(startIndex..<endIndex, in: self)
		let match = regex.firstMatch(in: self, options: [], range: range)
		let matchedRange = (match?.range(at: 1)).flatMap { Range($0, in: self) }

		return matchedRange.map { .init(self[$0]) }
	}

	func date(for year: Int = 1999) throws -> Date? {
		var date: Date? = nil
		let string = "\(self)/\(year)"
		let range = NSRange(string.startIndex..<string.endIndex, in: string)
		let detector = try Self.dateDetector.get()
		for result in detector.matches(in: string, options: [], range: range) {
			date = result.date
			if date != nil { break }
		}
		return date
	}

	func year() -> Int? {
		text(extractedFrom: .year).flatMap {
			.init($0)
		}
	}

	func cityState() throws -> (String, String)? {
		var cityState: (String, String)? = nil
		let string = "\(String.addressLead) \(String.sampleStreetAddress), \(self) \(String.sampleZipCode)"
		let range = NSRange(string.startIndex..<string.endIndex, in: string)
		let keys: [NSTextCheckingKey] = [.city, .state]
		let detector = try Self.addressDetector.get()
		for result in detector.matches(in: string, options: [], range: range) {
			if let components = result.addressComponents {
				let values = keys.compactMap { components[$0] }
				if values.count == 2 {
					cityState = (values[0], values[1])
					break
				}
			}
		}
		return cityState
	}
}

// MARK: -
private extension String {
	static let addressLead = "The address is"
	static let sampleStreetAddress = "123 Main Street"
	static let sampleZipCode = "99999"

	static let dateDetector = Result<NSDataDetector, Error> {
		try dataDetector(for: .date)
	}

	static let addressDetector = Result<NSDataDetector, Error> {
		try dataDetector(for: .address)
	}

	static func dataDetector(for type: NSTextCheckingResult.CheckingType) throws -> NSDataDetector {
		try .init(types: type.rawValue)
	}
}

// MARK: -
private extension NSRegularExpression {
	static var year: Self { try! .init(pattern: "([0-9]{4})") }
}
