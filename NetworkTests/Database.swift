//
//  Database.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB

/// A type responsible for initializing the application database.
///
/// See AppDelegate.setupDatabase()
struct Database {
    
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        // Connect to the database
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
        //        let dbQueue = try DatabaseQueue(path: path)
        var configuration = Configuration()
        configuration.passphrase = "secret"
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
        
        migrator.registerMigration("UserProperty") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "repeatItem") { t in
                t.autoIncrementedPrimaryKey("id")
                
                // Sort player names in a localized case insensitive fashion by default
                // See https://github.com/groue/GRDB.swift/blob/master/README.md#unicode
                t.column("key", .text).notNull().collate(.localizedCaseInsensitiveCompare)
                
                t.column("value", .text).notNull()
            }
        }
        
        //        migrator.registerMigration("fixtures") { db in
        //            // Populate the players table with random data
        //            for _ in 0..<8 {
        //                var player = Player(id: nil, name: Player.randomName(), score: Player.randomScore())
        //                try player.insert(db)
        //            }
        //        }
        
        //        // Migrations for future application versions will be inserted here:
        //        migrator.registerMigration(...) { db in
        //            ...
        //        }
        
        return migrator
    }
}

