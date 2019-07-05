//
//  ResultModel.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ObjectMappable: Mappable {

    var code: String { get set }
    var isSuccess: Bool { get set }
    var message: String { get set }
    var fullMessage: String { get set }
    var timestamp: String { get set }
}

struct ResultModel<M: Mappable>: ObjectMappable {
    var fullMessage: String = ""
    var message: String = ""
    var timestamp: String = ""
    var result: M?
    var code: String = ""
    var isSuccess: Bool = false

    init() {}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        fullMessage   <- map["fullMessage"]
        message   <- map["message"]
        timestamp   <- map["timestamp"]
        result   <- map["result"]
        code   <- map["code"]
        isSuccess   <- map["isSuccess"]
    }
}

struct ListModel<M: Mappable>: ObjectMappable {
    var fullMessage: String = ""
    var message: String = ""
    var timestamp: String = ""
    var result: [M] = []
    var code: String = ""
    var isSuccess: Bool = false

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        fullMessage   <- map["fullMessage"]
        message   <- map["message"]
        timestamp   <- map["timestamp"]
        result   <- map["result"]
        code   <- map["code"]
        isSuccess   <- map["isSuccess"]
    }
}
