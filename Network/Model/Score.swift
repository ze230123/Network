//
//  Score.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import ObjectMapper

let arrayTransform = TransformOf<String, [String]>(fromJSON: { (value: [String]?) -> String? in
    // 把值从 String? 转成 Int?
    return value?.joined(separator: "/")
}, toJSON: { (value: String?) -> [String]? in
    // 把值从 Int? 转成 String?
    if let value = value {
        return value.components(separatedBy: "/")
    }
    return nil
})

struct Score: Mappable {

    var numId: Int = 0
    var scoreType: Int = 0
    var total: Int = 0
    var courseTypeId: Int = 0
    var rank: Int = 0
    var provinceNumId: Int = 0

    var subjects: String = ""
    var chooseLevelOrSubjects: String = ""
    var provinceName: String = ""

    var jsChooseName1: String = ""
    var jsChooseName2: String = ""

    var jsChooseLevel1: String = ""
    var jsChooseLevel2: String = ""

    var isGaoKao: Bool {
        return scoreType == 2
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        chooseLevelOrSubjects   <- map["chooseLevelOrSubjects"]
        provinceName   <- map["provinceName"]

        guard (map.context as? Context) == nil else {
            batabaseMapping(map: map)
            return
        }
        subjects   <- (map["chooseSubjectsFormat"], arrayTransform)

        numId   <- map["numId"]
        scoreType   <- map["scoreType"]
        total   <- map["total"]
        courseTypeId   <- map["courseTypeId"]
        rank   <- map["rank"]
        provinceNumId   <- map["provinceNumId"]

        jsChooseName1   <- map["chooseLevelFormat.0.name"]
        jsChooseName2   <- map["chooseLevelFormat.1.name"]

        jsChooseLevel1  <- map["chooseLevelFormat.0.value"]
        jsChooseLevel2  <- map["chooseLevelFormat.1.value"]
    }

    mutating func batabaseMapping(map: Map) {
        subjects   <- map["subjects"]

        numId   <- (map["numId"], intTransform)
        scoreType   <- (map["scoreType"], intTransform)
        total   <- (map["total"], intTransform)
        courseTypeId   <- (map["courseTypeId"], intTransform)
        rank   <- (map["rank"], intTransform)
        provinceNumId   <- (map["provinceNumId"], intTransform)

        jsChooseName1   <- map["jsChooseName1"]
        jsChooseName2   <- map["jsChooseName2"]

        jsChooseLevel1  <- map["jsChooseLevel1"]
        jsChooseLevel2  <- map["jsChooseLevel2"]
    }
}

struct ChooseLevelFormat: Mappable {
    var name: String = ""
    var value: String = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        name   <- map["name"]
        value   <- map["value"]
    }
}

/*
//分数信息部分：
scoreNumId("scoreNumId", "numId"),//成绩NumId
scoreProvinceNumId("scoreProvinceNumId", "provinceNumId"),//省份Id
scoreProvinceName("scoreProvinceName", "provinceName"),//省份名称
total("total", "total"),//成绩总分
courseTypeId("courseTypeId", "courseTypeId"),//科目1=文科0=理科-1=不限
rank("rank", "rank"),//位次
chooseLevelOrSubjects("chooseLevelOrSubjects", "chooseLevelOrSubjects"),//选测等级（省份：江苏，格式:物理=A,化学=B）新高考选科（省份：浙江、上海，格式:思想政治,历史,地理）
scoreType("scoreType", "scoreType"),//成绩类型1=普通成绩2=高考成绩3=线差成绩4=位次
chooseLevelFormat("chooseLevelFormat", "chooseLevelFormat"),//选测科目或等级格式化 todo 对象 ChooseLevelFormatBeanConvert
chooseSubjectsFormat("chooseSubjectsFormat", "chooseSubjectsFormat"),//选科格式化 todo 对象 ChooseLevelSubjectFormatConvert

//批次信息部分：
batchProvinceName("batchProvinceName", "provinceName"),//省份名称
course("course", "course"),//科目
batch("batch", "batch"),//批次
batchName("batchName", "batchName"),//批次名称
score("score", "score"),//分数
isHaveGroups("isHaveGroups", "isHaveGroups"),//是否包含分线
batchId("batchId", "id"),//id
groups("groups", "groups"),//批次分组，如：有些单批次会分为两段。从志愿规则配置里判断是否有开始分段 todo 对象ZyRuleConfigBatchGroupDtoConvert
batchInnerPosition("batchInnerPosition", "batchInnerPosition");//分段批次被选中的下标
*/
