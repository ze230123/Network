//
//  UserInfoHelper.swift
//  Network
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB
import ObjectMapper

class DBManager {
    private var dbQueue: DatabaseQueue!
    private var path: String
    private let fileManager = FileManager.default

    init(name: String) {
        let url = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        path = url?.appendingPathComponent("dbCache", isDirectory: true).path ?? ""

        createDirectory()

        let filePath = makeFilePath(for: "\(name)")
        print(filePath)
        dbQueue = try! UserInfoDatabase.openDatabase(atPath: filePath, password: "")
    }
}

extension DBManager {
    func add(_ item: Score) {
        let json = Mapper(context: Context()).toJSON(item)
        let propertys = json.map { ScoreProperty(key: $0.key, value: "\($0.value)")}

        try! dbQueue.write { (db) in
            for i in 0..<propertys.count {
                var item = propertys[i]
                let count = try! ScoreProperty.filter(Column("key") == item.key).fetchCount(db)
                if count == 0 {
                    print("添加")
                    try! item.insert(db)
                } else {
                    print("修改", count)
                    try! item.update(db)
                }
            }
        }
    }

    func read() -> Score? {
        let result = try! dbQueue.write { (db) in
            return try! ScoreProperty.fetchAll(db)
        }
        var json: [String: Any] = [:]
        for item in result {
            json[item.key] = item.value
        }
        print(json)
        return Score(JSON: json, context: Context())
    }
}

private extension DBManager {
    /// 创建文件夹
    func createDirectory() {
        guard !fileManager.fileExists(atPath: path) else {
            return
        }
        print(path)
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    /// 文件路径
    func makeFilePath(for key: String) -> String {
        return "\(path)/\(makeFileName(for: key))"
    }

    /// 文件名
    func makeFileName(for key: String) -> String {
        let fileName = key
        print("keyMd5: ", fileName)
        return "\(fileName).sqlite"
    }
}
