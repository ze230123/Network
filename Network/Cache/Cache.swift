//
//  Cache.swift
//  Network
//
//  Created by youzy01 on 2019/7/12.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

/// 缓存类
class Cache {
}

/// 磁盘配置
struct DiskConfig {
    /// 文件夹名字
    public let name: String
    ///磁盘缓存存储的最大大小（以字节为单位）
    public let maxSize: UInt
    /// 过期时间
    public let expiry: Expiry
}

/// 磁盘存储
class DiskStorage {
    /// 文件管理者
    let fileManager: FileManager
    /// 配置
    let config: DiskConfig
    /// 缓存路径
    let path: String

    init(config: DiskConfig, fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        self.config = config

        let url = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        path = url?.appendingPathComponent(config.name, isDirectory: true).path ?? ""

        guard !fileManager.fileExists(atPath: path) else {
            return
        }

        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension DiskStorage {
    /// 存储缓存
    func setObject(_ object: String, forKey key: String, expiry: Expiry? = nil) {
    }

    /// 获取指定缓存
    func object(forKey key: String) -> String {
        return ""
    }

    /// 删除指定缓存
    func removeObject(forKey key: String) {
    }

    /// 删除全部缓存
    func removeAll() {
//        try fileManager.removeItem(atPath: path)
//        try createDirectory()
    }

    /// 删除到期缓存
    func removeExpiredObjects() {
    }

    /// 计算总磁盘缓存大小。
    func totalSize() -> Double {
        return 0
    }
}
