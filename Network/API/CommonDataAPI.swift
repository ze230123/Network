//
//  CommonDataAPI.swift
//  YouZhiYuan
//
//  Created by youzy01 on 2019/5/18.
//  Copyright © 2019 泽i. All rights reserved.
//

import Moya

enum CommonDataAPI {
    /// 获取学校列表
    case schoolList(id: Int)
    /// 获取高考版开启状态
    case gkStatus(id: Int)
    /// 获取成绩对应的批次
    case batch(proId: Int, total: Int, course: Int)

//    /// 根据分数获取批次
//    case normalBatch(proId: Int, total: Int, course: Int)
    /// 新高考省份获取批次
    case newGKBatch(proId: Int, total: Int)

    /// 江苏一分一段
//    case jsYfyd(score: Int)
    /// 极验行为验证初始化
    case captchaInit
    /// 极验行为验证
    case captchaVerify([String: Any])
}

extension CommonDataAPI: ApiTargetType {
    var encoding: ParameterEncoding {
        switch self {
        case .captchaInit, .captchaVerify:
            return JSONEncoding.default
        default:
            return URLEncoding.queryString
        }
    }

    var policy: CachePolicy {
        switch self {
        case .schoolList:
            return .firstCache
        case .batch:
            return .cache
        default:
            return .none
        }
    }

//    var module: APIModule {
//        switch self {
//        case .batch, .jsYfyd:
//            return .pcl
//        default:
//            return .other
//        }
//    }

    var parameters: [String: Any] {
        switch self {
        case .schoolList(let id):
            return ["parentId": id, "count": 0]
        case .gkStatus(let id):
            return ["provinceId": id]
        case let .batch(proId, total, course):
            return ["provinceId": proId, "totalScore": total, "course": course]
        case let .newGKBatch(proId, total):
            return ["provinceId": proId, "totalScore": total]
//        case .jsYfyd(let score):
//            return [
//                "provinceNumId": newUser.provinceId,
//                "courseType": newUser.courseType.rawValue,
//                "score": score
//            ]
        case .captchaInit:
            return [
                "userId": "02bc0d0e15fd6063ce10ce1351e39dea",
                "clientType": "native",
                "ipAddress": "unknow"
            ]
        case .captchaVerify(let dict):
            return dict
        }
    }

    var path: String {
        switch self {
        case .schoolList:
            return "/Common/Areas/QueryList"
        case .gkStatus:
            return "/Configuration/GaoKao/IsOpened"
        case .batch:
            return "/TZY/Func/GetRightBatch"
        case .newGKBatch:
            return "/TZY/Func/GetNewGaoKaoRightBatch"
//        case .jsYfyd:
//            return "/ScoreLines/YFYD/GetByScore"
        case .captchaInit:
            return "/Common/GtCaptcha/Init"
        case .captchaVerify:
            return "/Common/GtCaptcha/Verify"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    var baseURL: URL {
        switch self {
        default:
            return URL(string: AppConstant.dataHost)!
        }
    }
}
