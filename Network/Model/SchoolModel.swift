//
//  SchoolModel.swift
//  Network
//
//  Created by youzy01 on 2019/7/10.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

/// 用户所在学校列表model
struct Schools: Mappable {
    var parentNumId: Int = 0
    var name: String = ""
    var id: String = ""
    var numId: Int = 0
    var fLetter: String = ""
    
    init(numId: Int, name: String) {
        self.numId = numId
        self.name = name
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        parentNumId     <- map["parentNumId"]
        name            <- map["name"]
        id              <- map["id"]
        numId           <- map["numId"]
        fLetter         <- map["fLetter"]
    }
}
