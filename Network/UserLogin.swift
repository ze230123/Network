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

import RxSwift

class LoginUtils {
    typealias UserIdBlock = (ResultModel<UserLogin>) throws -> Int

    static let getUserId: UserIdBlock = { (root: ResultModel<UserLogin>) in
        guard let state = root.result?.state else {
            throw NetworkError.message("未知错误，登陆失败")
        }
        guard state == .success else {
            throw NetworkError.message(state.description)
        }
        guard let userId = root.result?.userId?.numId else {
            throw NetworkError.message("用户ID获取失败")
        }
        return userId
    }

    class func getUserInfo(id: Int) -> Observable<ResultModel<User>> {
        return server.request(api: NewAccountAPI.info(numId: id)).mapObject(User.self)
    }

    class func getGKStatus(info: UserInfo) -> Observable<UserInfo> {
        guard let user = info.user else {
            return Observable.error(NetworkError.message("用户信息为空"))
        }
        let api = CommonDataAPI.gkStatus(id: user.provinceId)
        return server
            .request(api: api)
            .mapStringModel()
            .map({ (root) -> UserInfo in
                var new = info
                new.isGaokao = root.result == "True"
                return new
            })
    }

    class func getScore(info: UserInfo) -> Observable<UserInfo> {
        guard let user = info.user else {
            return Observable.error(NetworkError.message("用户信息为空"))
        }
        let api = NewAccountAPI.scoreByUserId(user: user, isGaokao: info.isGaokao)
        return server
            .request(api: api)
            .mapObject(Score.self)
            .map({ (root) in
                guard let score = root.result else {
                    throw NetworkError.message("获取成绩失败")
                }
                var new = info
                new.score = score
                return new
            })
    }
}
