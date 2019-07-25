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

    /// 用于判断两个数据是否一样
    var hash: String { get }
}

struct ResultModel<M: Mappable>: ObjectMappable {
    var fullMessage: String = ""
    var message: String = ""
    var timestamp: String = ""
    var result: M?
    var code: String = ""
    var isSuccess: Bool = false

    var hash: String {
        print("对象hash")
        return result?.toJSON().map { "\($0.key)=\($0.value)" }.sorted().joined(separator: ",").MD5 ?? ""
    }

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

    var hash: String {
        let arr = result.map { $0.toJSON().map { "\($0.key)=\($0.value)" }.sorted().joined(separator: ",") }.joined(separator: ",")
        return arr.MD5
    }

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

struct StringModel: ObjectMappable {
    var fullMessage: String = ""
    var message: String = ""
    var timestamp: String = ""
    var result: String = ""
    var code: String = ""
    var isSuccess: Bool = false

    var hash: String {
        return result.MD5
    }

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
