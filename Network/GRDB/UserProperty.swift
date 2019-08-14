//
//  UserProperty.swift
//  Network
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import GRDB

struct UserProperty {
    var key: String
    var value: String

    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

extension UserProperty: Codable, FetchableRecord, MutablePersistableRecord {
    enum Columns {
        static let key = Column(CodingKeys.key)
        static let value = Column(CodingKeys.value)
    }
}

struct ScoreProperty {
    var key: String
    var value: String

    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

extension ScoreProperty: Codable, FetchableRecord, MutablePersistableRecord {
    enum Columns {
        static let key = Column(CodingKeys.key)
        static let value = Column(CodingKeys.value)
    }
}
