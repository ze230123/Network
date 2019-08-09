//
//  Model.swift
//  NetworkTests
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB

struct UserProperty {
    var id: Int64?
    var key: String
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

extension UserProperty: Codable, FetchableRecord, MutablePersistableRecord {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let key = Column(CodingKeys.key)
        static let value = Column(CodingKeys.value)
    }
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
