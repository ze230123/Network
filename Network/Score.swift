//
//  Score.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

struct Score: Mappable {
    var chooseLevelOrSubjects: String?
    var provinceName: String?
    var chooseLevelFormat = [ChooseLevelFormat]()
    var chooseSubjectsFormat = [String]()
    var numId: Int = 0
    var scoreType: Int = 0
    var total: Int = 0
    var courseTypeId: Int = 0
    var rank: Int = 0
    var provinceNumId: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        chooseLevelOrSubjects   <- map["chooseLevelOrSubjects"]
        provinceName   <- map["provinceName"]
        chooseLevelFormat   <- map["chooseLevelFormat"]
        chooseSubjectsFormat   <- map["chooseSubjectsFormat"]
        numId   <- map["numId"]
        scoreType   <- map["scoreType"]
        total   <- map["total"]
        courseTypeId   <- map["courseTypeId"]
        rank   <- map["rank"]
        provinceNumId   <- map["provinceNumId"]
    }
}

struct ChooseLevelFormat: Mappable {
    var name: String?
    var value: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name   <- map["name"]
        value   <- map["value"]
    }
}
