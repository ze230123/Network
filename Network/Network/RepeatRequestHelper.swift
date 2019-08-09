//
//  File.swift
//  Network
//
//  Created by youzy01 on 2019/7/26.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB

/// 网络链接请求记录
struct RepeatItem {
    var id: Int64?
    var path: String = ""
    var date: Date = Date()

    init(path: String) {
        self.path = path
    }

    init(path: String, date: Date) {
        self.path = path
        self.date = date
    }
}

extension RepeatItem: Codable, FetchableRecord, MutablePersistableRecord, TableRecord {
    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.path)
        static let score = Column(CodingKeys.date)
    }

    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

/// 网络请求次数帮助类
class RepeatHelper {
    static var maxCount: Int = 5

    static let share = RepeatHelper(queue: dbQueue)

    private let queue: DatabaseQueue

    init(queue: DatabaseQueue) {
        self.queue = queue
    }

    /// 添加网络api记录
    func add(_ path: String) {
        var item = RepeatItem(path: path.MD5)
        do {
            try queue.write { db in
                try item.insert(db)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    /// 验证api请求是否有效
    func valid(of key: String) -> Bool {
        let path = Column("path")
        let date = Column("date")

        let oldDate = Date(timeIntervalSinceNow: -60)

        var count: Int = 0
        do {
            try queue.write { db in
                count = try RepeatItem.filter(path == key.MD5).filter(date > oldDate).fetchCount(db)
                print("查找数量", count)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return count < RepeatHelper.maxCount
    }
    /// 删除api请求记录
    func removeExpriy() {
        let date = Column("date")
        let oldDate = Date(timeIntervalSinceNow: -60)
        do {
            _ = try queue.write { db in
                try RepeatItem.filter(date < oldDate).deleteAll(db)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
