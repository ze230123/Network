//
//  User.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    var gkYear: Int = 0
    var isZZUser: Bool = false
    var className: String?
    var cityId: Int = 0
    var provinceName: String?
    var creationTime: String?
    var updateGaoKaoCount: Int = 0
    var active: Bool = false
    var secretName: String?
    var id: String?
    var numId: Int = 0
    var provinceId: Int = 0
    var schoolName: String?
    var countyId: Int = 0
    var identityExpirationTime: String?
    var cityName: String?
    var realName: String?
    var isElective: Bool = false
    var gender: Int = 0
    var mobilePhone: String?
    var lastLoginDate: String?
    var username: String?
    var userPermissionId: Int = 0
    var zzCount: Int = 0
    var courseType: Int = 0
    var avatarUrl: String?
    var schoolId: Int = 0
    var countyName: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        gkYear   <- map["gkYear"]
        isZZUser   <- map["isZZUser"]
        className   <- map["class"]
        cityId   <- map["cityId"]
        provinceName   <- map["provinceName"]
        creationTime   <- map["creationTime"]
        updateGaoKaoCount   <- map["updateGaoKaoCount"]
        active   <- map["active"]
        secretName   <- map["secretName"]
        id   <- map["id"]
        numId   <- map["numId"]
        provinceId   <- map["provinceId"]
        schoolName   <- map["schoolName"]
        countyId   <- map["countyId"]
        identityExpirationTime   <- map["identityExpirationTime"]
        cityName   <- map["cityName"]
        realName   <- map["realName"]
        isElective   <- map["isElective"]
        gender   <- map["gender"]
        mobilePhone   <- map["mobilePhone"]
        lastLoginDate   <- map["lastLoginDate"]
        username   <- map["username"]
        userPermissionId   <- map["userPermissionId"]
        zzCount   <- map["zzCount"]
        courseType   <- map["courseType"]
        avatarUrl   <- map["avatarUrl"]
        schoolId   <- map["schoolId"]
        countyName   <- map["countyName"]
    }
}
