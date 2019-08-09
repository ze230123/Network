//
//  ExpiryTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network

class ExpiryTests: XCTestCase {

    func testNever() {
        let date = Date(timeIntervalSince1970: 60 * 60 * 24 * 365 * 100)
        let expiry = Expiry.never

        XCTAssertEqual(date, expiry.date)
    }

    func testSeconds() {
        let date = Date().addingTimeInterval(1000)
        let expriy = Expiry.time(.seconds(1000))

        XCTAssertEqual(
            date.timeIntervalSinceReferenceDate,
            expriy.date.timeIntervalSinceReferenceDate,
            accuracy: 0.1
        )
    }

    func testDate() {
        let date = Date().addingTimeInterval(100)
        let expriy = Expiry.date(date)

        XCTAssertEqual(date, expriy.date)
    }
}
