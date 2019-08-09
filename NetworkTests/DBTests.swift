//
//  DBTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network
import GRDB

//class DBTests: XCTestCase {
//    var dbQueue: DatabaseQueue!
//
//    override func setUp() {
//        let databaseURL = try FileManager.default
//            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            .appendingPathComponent("testdb.sqlite")
//        print(databaseURL.path)
//        dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//    func testBatchInsrt() {
//        var arr = [
//            UserProperty(key: "id", value: "12345"),
//            UserProperty(key: "name", value: "llllllll"),
//            UserProperty(key: "url", value: "image.com/1234.jpeg"),
//            UserProperty(key: "province", value: "843"),
//            UserProperty(key: "provinceName", value: "浙江"),
//        ]
//
//        func insertUserPro() {
//            try! dbQueue.write { (db) in
//                for i in 0..<arr.count {
//                    try! arr[i].insert(db)
//                }
//            }
//        }
//    }
//}
