//
//  RepeatHelperTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/7/29.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network
import GRDB

class RepeatHelperTests: XCTestCase {

    var dbQueue: DatabaseQueue!

    var helper: RepeatHelper!

    private func setupDatabase() throws {
        let databaseURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("testdb.sqlite")
        print(databaseURL.path)
        dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)

        // Be a nice iOS citizen, and don't consume too much memory
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
//        dbQueue.setupMemoryManagement(in: application)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! setupDatabase()
        helper = RepeatHelper(queue: dbQueue)
    }

    override func tearDown() {
        _ = try! dbQueue.write { db in
            try RepeatItem.deleteAll(db)
        }
    }

//    func testsAdd() {
//        helper.add("path1")
//
//        let path = Column("path")
//
//        var array: [RepeatItem] = []
//        do {
//            try dbQueue.write { db in
//                array = try RepeatItem.filter(path == "path1").fetchAll(db)
//            }
//        } catch let error {
//            print(error)
//        }
//
//        XCTAssert(array.count == 1)
//        XCTAssertNotNil(array.first)
//        XCTAssertEqual(array.first?.path, "path1")
//    }
//
//    func testsDeleteExpriyNot() {
//        let item1 = RepeatItem(path: "path111", date: Date(timeIntervalSinceNow: -30))
//        let item2 = RepeatItem(path: "path222", date: Date(timeIntervalSinceNow: -64))
//
//        helper.add(item1)
//        helper.add(item2)
//        helper.removeExpriy()
//
//        let date = Column("date")
//        let oldDate = Date(timeIntervalSinceNow: -60)
//
//        var array: [RepeatItem] = []
//        do {
//            try dbQueue.write { db in
//                array = try RepeatItem.filter(date > oldDate).fetchAll(db)
//            }
//        } catch let error {
//            print(error)
//        }
//
//        XCTAssert(array.count == 1)
//        XCTAssertNotNil(array.first)
//        XCTAssertEqual(array.first?.path, "path111")
//    }
//
//    func testsVaild() {
//        let item1 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -30))
//        let item2 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -43))
//        let item3 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -23))
//        let item4 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -87))
//
//        helper.add(item1)
//        helper.add(item2)
//        helper.add(item3)
//        helper.add(item4)
//
//        XCTAssertTrue(helper.valid(of: "valid"))
//    }
//
//    func testsInvalid() {
//        let item1 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -30))
//        let item2 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -43))
//        let item3 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -23))
//        let item4 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -54))
//        let item5 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -10))
//        let item6 = RepeatItem(path: "valid", date: Date(timeIntervalSinceNow: -87))
//
//        helper.add(item1)
//        helper.add(item2)
//        helper.add(item3)
//        helper.add(item4)
//        helper.add(item5)
//        helper.add(item6)
//
//        XCTAssertFalse(helper.valid(of: "valid"))
//    }
}
