//
//  User.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

struct Context: MapContext {
    var type = "DatabaseQueue"
}

let intTransform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
    // 把值从 String? 转成 Int?
    return value?.intValue
}, toJSON: { (value: Int?) -> String? in
    // 把值从 Int? 转成 String?
    if let value = value {
        return value.stringValue
    }
    return nil
})

let boolTransform = TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
    return value?.boolValue
}, toJSON: { (value: Bool?) -> String? in
    // 把值从 Int? 转成 String?
    if let value = value {
        return value.stringValue
    }
    return nil
})

extension String {
    var intValue: Int {
        return Int(self) ?? 0
    }

    var boolValue: Bool? {
        return Bool(self)
    }
}

extension Int {
    var stringValue: String {
        return "\(self)"
    }
}

struct User: Mappable {
    var gkYear: Int = 0
    var isZZUser: Bool = false
    var className: String = ""
    var cityId: Int = 0
    var provinceName: String = ""
    var creationTime: String = ""
    var updateGaoKaoCount: Int = 0
    var active: Bool = false
    var secretName: String = ""
    var id: String = ""
    var numId: Int = 0
    var provinceId: Int = 0
    var schoolName: String = ""
    var countyId: Int = 0
    var identityExpirationTime: String = ""
    var cityName: String = ""
    var realName: String = ""
    var isElective: Bool = false
    var gender: Int = 0
    var mobilePhone: String = ""
    var lastLoginDate: String = ""
    var username: String = ""
    var userPermissionId: Int = 0
    var zzCount: Int = 0
    var courseType: Int = 0
    var avatarUrl: String = ""
    var schoolId: Int = 0
    var countyName: String = ""

    var isLogin: Bool = false

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        className               <- map["class"]
        provinceName            <- map["provinceName"]
        creationTime            <- map["creationTime"]
        secretName              <- map["secretName"]
        id                      <- map["id"]
        schoolName              <- map["schoolName"]
        identityExpirationTime  <- map["identityExpirationTime"]
        cityName                <- map["cityName"]
        realName                <- map["realName"]
        gender                  <- map["gender"]
        mobilePhone             <- map["mobilePhone"]
        lastLoginDate           <- map["lastLoginDate"]
        username                <- map["username"]
        userPermissionId        <- map["userPermissionId"]
        avatarUrl               <- map["avatarUrl"]
        countyName              <- map["countyName"]

        guard (map.context as? Context) == nil else {
            databaseMapping(map: map)
            return
        }
        isZZUser                <- map["isZZUser"]
        isElective              <- map["isElective"]
        active                  <- map["active"]

        gkYear                  <- map["gkYear"]
        cityId                  <- map["cityId"]
        updateGaoKaoCount       <- map["updateGaoKaoCount"]
        numId                   <- map["numId"]
        provinceId              <- map["provinceId"]
        countyId                <- map["countyId"]
        gender                  <- map["gender"]
        userPermissionId        <- map["userPermissionId"]
        zzCount                 <- map["zzCount"]
        courseType              <- map["courseType"]
        schoolId                <- map["schoolId"]
    }

    mutating func databaseMapping(map: Map) {
        gkYear                  <- (map["gkYear"], intTransform)
        cityId                  <- (map["cityId"], intTransform)
        updateGaoKaoCount       <- (map["updateGaoKaoCount"], intTransform)
        numId                   <- (map["numId"], intTransform)
        provinceId              <- (map["provinceId"], intTransform)
        countyId                <- (map["countyId"], intTransform)
        gender                  <- (map["gender"], intTransform)
        userPermissionId        <- (map["userPermissionId"], intTransform)
        zzCount                 <- (map["zzCount"], intTransform)
        courseType              <- (map["courseType"], intTransform)
        schoolId                <- (map["schoolId"], intTransform)

        isZZUser                <- (map["isZZUser"], boolTransform)
        isElective              <- (map["isElective"], boolTransform)
        active                  <- (map["active"], boolTransform)

        isLogin                 <- (map["isLogin"], boolTransform)
    }
}
