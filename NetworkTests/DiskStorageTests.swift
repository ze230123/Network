//
//  DiskStorageTests.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import XCTest
@testable import Network

class DiskStorageTests: XCTestCase {
    private var store: DiskStorage<String>!
    private let key = "testkey"
    private let fileManager = FileManager()

    private let object = "测试数据"

    override func setUp() {
        super.setUp()
        store = DiskStorage<String>(
            config: DiskConfig(name: "Test", maxSize: 0, expiry: .never),
            transformer: TransformerFactory.forString()
        )
    }

    override func tearDown() {
        store.removeAll()
        super.tearDown()
    }

    func testInit() {
        let exists = fileManager.fileExists(atPath: store.path)
        XCTAssertTrue(exists)
    }

    func testsetObject() {
        store.setObject(object, forKey: key)
        let fileExist = fileManager.fileExists(atPath: store.makeFilePath(for: key))
        XCTAssertTrue(fileExist)
    }

    func testGetObject() {
        store.setObject(object, forKey: key)
        let obj = store.object(forKey: key)
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj, object)
    }

    func testRemoveObject() {
        store.setObject(object, forKey: key)
        store.removeObject(forKey: key)
        let fileExist = fileManager.fileExists(atPath: store.makeFilePath(for: key))
        XCTAssertFalse(fileExist)
    }

    func testExpiredObject() {
        store.setObject(object, forKey: key, expiry: .seconds(0.9))
        XCTAssertFalse(store.isExpiredObject(forKey: key))
        sleep(1)
        XCTAssertTrue(store.isExpiredObject(forKey: key))
    }

    func testCreateDirectory() {
        store.removeAll()
        XCTAssertTrue(fileManager.fileExists(atPath: store.path))
        let countents = try? fileManager.contentsOfDirectory(atPath: store.path)
        XCTAssertEqual(countents?.count, 0)
    }

    func testClearExpired() {
        let expiry1 = Expiry.date(Date().addingTimeInterval(-10000))
        let expiry2 = Expiry.date(Date().addingTimeInterval(10000))

        let key1 = "item1"
        let key2 = "item2"

        store.setObject(object, forKey: key1, expiry: expiry1)
        store.setObject(object, forKey: key2, expiry: expiry2)

        store.removeExpiredObjects()

        let object1 = store.object(forKey: key1)
        let object2 = store.object(forKey: key2)

        XCTAssertNil(object1)
        XCTAssertNotNil(object2)
    }

}
