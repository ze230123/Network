//
//  NewAccountAPI.swift
//  YouZhiYuan
//
//  Created by youzy01 on 2019/4/22.
//  Copyright © 2019 泽i. All rights reserved.
//

import Moya

enum NewAccountAPI {
    case checkGateway([String: Any])
    /// 验证手机号是否已注册
    case verifyPhone(phone: String, sms: String)
    /// 发送验证码
    case sms(phone: String)
    /// 短信验证码是否有效
    case verifySms(phone: String, sms: String)
    /// 获取用户信息
    case info(numId: Int)
    /// 注册
//    case register(NewRegisterParameter)
    /// 账号密码登陆验证
    case login(userName: String, password: String)
    /// 更新用户信息
//    case update(proId: String, year: Int, type: CouseType)
    /// 获取用户当前使用成绩信息
    case scoreByUserId(user: User, isGaokao: Bool)
    /// 创建成绩
//    case creatScore(ScoreParameter)
    /// 获取单个成绩
    case score(numId: Int)
    /// 重置密码
    case reset(name: String, code: String, pwd: String)
    /// 第三方登陆验证
    case third(openId: String, type: Int)
    /// 第三方登陆绑定手机号
//    case thirdBind(ThirdBindPhoneParameter)
    /// 会员卡登陆
    case cardLogin(card: String, pwd: String)
    /// 会员卡绑定手机号
//    case cardBind(CardBindPhoneParameter)
}

extension NewAccountAPI: ApiTargetType {
    
    var encoding: ParameterEncoding {
        switch self {
        case .info, .score:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }

//    var policy: CachePolicy {
//        switch self {
//        default:
//            return .none
//        }
//    }

//    var module: APIModule {
//        return .other
//    }

    var parameters: [String: Any] {
        switch self {
        case let .checkGateway(dict):
            return dict
        case let .verifyPhone(phone, sms):
            return [
                "mobile": phone,
                "authCode": sms
            ]
        case .sms(let phone):
            return ["mobile": phone]
        case let .info(numId):
            return ["numId": numId, "isFillAreaName": true.stringValue]
//        case .register(let parameter):
//            return parameter.parameters
        case let .verifySms(phone, sms):
            return ["mobile": phone, "code": sms]
        case let .login(userName, password):
            return ["username": userName, "password": password]
//        case let .update(proId, year, type):
//            return [
//                "id": newUser.id,
//                "provinceNumId": proId,
//                "examYear": year,
//                "couseType": type.rawValue
//            ]
        case let .scoreByUserId(user, isGaoKao):
            return [
                "userNumId": user.numId,
                "provinceNumId": user.provinceId,
                "isGaoKao": isGaoKao,
                "isFillProvinceName": true
            ]
//        case .creatScore(let parameter):
//            return parameter.parameters
        case let .score(numId):
            return ["numId": numId]
        case let .reset(name, code, pwd):
            return ["mobile": name, "mobileAuthCode": code, "password": pwd]
        case let .third(openId, type):
            return ["openId": openId, "socialLoginType": type]
        case let .cardLogin(card, pwd):
            return ["cardNo": card, "password": pwd]
//        case .thirdBind(let parameter):
//            return parameter.parameters
//        case .cardBind(let parameter):
//            return parameter.parameters
        }
    }

    var path: String {
        switch self {
        case .checkGateway:
            return "/Users/OnePass/CheckGateway"

        case .verifyPhone:
            return "/Users/ValidateMobile"
        case .sms:
            return "/Users/SMS/Send"
        case .info:
            return "/Users/GetBrief"
//        case .register:
//            return "/Users/Register"
        case .verifySms:
            return "/Users/SMS/Validate"
        case .login:
            return "/Users/Validate"
//        case .update:
//            return "/Users/UpdateGaoKaoInfo"
        case .scoreByUserId:
            return "/Users/Scores/GetByUserNumId"
//        case .creatScore:
//            return "/Users/Scores/Insert"
        case .score:
            return "/Users/Scores/Get"
        case .reset:
            return "/Users/ResetPassword"
        case .third:
            return "/Users/Socials/Validate"
        case .cardLogin:
            return "/Cards/Validate"
//        case .thirdBind:
//            return "/Users/Socials/BindMobile"
//        case .cardBind:
//            return "/Users/CardBindUser"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    var baseURL: URL {
        return URL(string: AppConstant.newHost)!
    }
}

extension Bool {
    var stringValue: String {
        return "\(self)"
    }
}
