//
//  String+CasingTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_CasingTests: XCTestCase {

    func testIsCapitalizedIsOnlyTrueForCapitalizedStrings() {
        XCTAssertTrue("Foobar".isCapitalized)
        XCTAssertTrue("Foo Bar".isCapitalized)
        XCTAssertFalse("Foo bar".isCapitalized)
    }

    func testIsLowercasedIsOnlyTrueForStringsThatCanBeAndAreLowercased() {
        XCTAssertTrue("foobar".isLowercased)
        XCTAssertFalse("fooBar".isLowercased)
        XCTAssertFalse("123".isLowercased)
    }

    func testIsUppercasedIsOnlyTrueForStringsThatCanBeAndAreUppercased() {
        XCTAssertTrue("FOOBAR".isUppercased)
        XCTAssertFalse("fooBar".isUppercased)
        XCTAssertFalse("123".isUppercased)
    }
}
