//
//  UserInfoDatabase.swift
//  Network
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB

struct UserInfoDatabase {
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String, password: String) throws -> DatabaseQueue {
        // Connect to the database
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
        //        let dbQueue = try DatabaseQueue(path: path)
        let configuration = Configuration()
//        configuration.passphrase = "secret"
        let dbQueue = try DatabaseQueue(path: path, configuration: configuration)
        // Define the database schema
        try migrator.migrate(dbQueue)
        
        return dbQueue
    }

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("v1") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "ScoreProperty") { t in
//                t.autoIncrementedPrimaryKey("id")
                // Sort player names in a localized case insensitive fashion by default
                // See https://github.com/groue/GRDB.swift/blob/master/README.md#unicode
                t.column("key", .text).notNull().collate(.localizedCaseInsensitiveCompare)
                t.column("value", .date).notNull()
                t.primaryKey(["key"])
            }

            try db.create(table: "UserProperty") { t in
                //                t.autoIncrementedPrimaryKey("id")
                // Sort player names in a localized case insensitive fashion by default
                // See https://github.com/groue/GRDB.swift/blob/master/README.md#unicode
                t.column("key", .text).notNull().collate(.localizedCaseInsensitiveCompare)
                t.column("value", .date).notNull()
                t.primaryKey(["key"])
            }
        }
        return migrator
    }

}
