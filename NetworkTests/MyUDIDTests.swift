//
//  MyUDIDTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/8/9.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network

class MyUDIDTests: XCTestCase {
    let uid = "1234567"

    override func setUp() {
//        UserDefaults.standard.removeObject(forKey: "uid")
        super.setUp()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "uid")
        super.tearDown()
    }

    func testsGetUdid() {
        let myUdid = MyUDID()

        let udid1 = myUdid.getUDID(uid: uid)
        print(udid1)
        let udid2 = myUdid.getUDID(uid: uid)
        print(udid2)

        XCTAssertEqual(udid1, udid2)
    }

    func testsChangeUid() {
        let myUdid = MyUDID()

        let udid1 = myUdid.getUDID(uid: "14053626")
        let udid2 = myUdid.getUDID(uid: "7654321")

        print(udid1)
        print(udid2)
        XCTAssertNotEqual(udid1, udid2)
    }
}
