//
//  NewModel.swift
//  Network
//
//  Created by youzy01 on 2019/7/4.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import ObjectMapper

protocol TestMappable: Mappable {
    var code: Int { get set }
    var msg: String { get set }
}

struct RootClass<M: Mappable>: TestMappable {
    var code: Int = 0
    var data: [M] = []
    var msg: String = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        code   <- map["code"]
        data   <- map["data"]
        msg   <- map["msg"]
    }
}

struct NewModel: Mappable {
    var cai: String?
    var image1: String?
    var bookmark: String?
    var theme_id: String?
    var cache_version: Int = 0
    var tag: String?
    var repost: String?
    var hate: String?
    var type: String?
    var ding: String?
    var profile_image: String?
    var videouri: String?
    var theme_type: String?
    var text: String?
    var comment: String?
    var is_gif: Bool = false
    var cdn_img: String?
    var love: String?
    var name: String?
    var videotime: Int = 0
    var screen_name: String?
    var width: String?
    var theme_name: String?
    var favourite: String?
    var t: Int = 0
    var image2: String?
    var image0: String?
    var height: String?
    var status: String?
    var original_pid: String?
    var created_at: String?
    var user_id: String?
    var bimageuri: String?
    var passtime: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        cai   <- map["cai"]
        image1   <- map["image1"]
        bookmark   <- map["bookmark"]
        theme_id   <- map["theme_id"]
        cache_version   <- map["cache_version"]
        tag   <- map["tag"]
        repost   <- map["repost"]
        hate   <- map["hate"]
        type   <- map["type"]
        ding   <- map["ding"]
        profile_image   <- map["profile_image"]
        videouri   <- map["videouri"]
        theme_type   <- map["theme_type"]
        text   <- map["text"]
        comment   <- map["comment"]
        is_gif   <- map["is_gif"]
        cdn_img   <- map["cdn_img"]
        love   <- map["love"]
        name   <- map["name"]
        videotime   <- map["videotime"]
        screen_name   <- map["screen_name"]
        width   <- map["width"]
        theme_name   <- map["theme_name"]
        favourite   <- map["favourite"]
        t   <- map["t"]
        image2   <- map["image2"]
        image0   <- map["image0"]
        height   <- map["height"]
        status   <- map["status"]
        original_pid   <- map["original_pid"]
        created_at   <- map["created_at"]
        user_id   <- map["user_id"]
        bimageuri   <- map["bimageuri"]
        passtime   <- map["passtime"]
    }
}
