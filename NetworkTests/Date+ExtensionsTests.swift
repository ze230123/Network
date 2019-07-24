//
//  Date+ExtensionsTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network

class Date_ExtensionsTests: XCTestCase {

    func testInThePast() {
        var date = Date(timeInterval: 100000, since: Date())
        XCTAssertFalse(date.inThePast)

        date = Date(timeInterval: -100000, since: Date())
        XCTAssertTrue(date.inThePast)
    }
}
