//
//  UserLogin.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

struct UserLogin: Mappable {
    var status: Int = 0
    var userId: UserId?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        status   <- map["status"]
        userId <- map["userIdDto"]
    }

    var isLoginSuccess: Bool {
        return status == 200
    }

    var state: LoginState? {
        return LoginState(rawValue: status)
    }
}

struct UserId: Mappable {
    /// 用户ObjectId
    var id: String = ""
    /// 用户NumId
    var numId: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id   <- map["id"]
        numId   <- map["numId"]
    }
}
