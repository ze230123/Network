//
//  LoginUtils.swift
//  Network
//
//  Created by youzy01 on 2019/7/12.
//  Copyright © 2019 youzy. All rights reserved.
//

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
                var new = info
                new.score = root.result
                return new
            })
    }
    
    class func checkInfoStatus(info: UserInfo) {
    }
    
    private let info: UserInfo
    private var status: Action = .main
    private var view: UIView
    
    init(info: UserInfo, view: UIView) {
        self.info = info
        self.view = view
    }
    
    func check() -> LoginUtils {
        guard let phone = info.user?.mobilePhone, !phone.isEmpty else {
            status = .phone
            return self
        }
        guard let provinceId = info.user?.provinceId, provinceId != 0 else {
            status = .info
            return self
        }
        guard let scoreId = info.score?.numId, scoreId != 0 else {
            status = .score
            return self
        }
        status = .main
        return self
    }
    
    func jump() -> LoginUtils {
        switch status {
        case .phone:
            MBHUD.showMessage("绑定手机号", to: view)
        case .info:
            MBHUD.showMessage("完善信息", to: view)
        case .score:
            MBHUD.showMessage("创建成绩", to: view)
        case .main:
            MBHUD.showMessage("跳转到首页", to: view)
        }
        return self
    }
    
    func save() {
        print("保存user信息")
        print("保存score信息")
    }
}

extension LoginUtils {
    enum Action {
        case phone
        case info
        case score
        case main
    }
}
