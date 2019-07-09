//
//  LoginState.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

enum LoginState: Int {
    /// 用户名或密码为空
    case nameOrPassIsEmpty = 100
    /// 登录成功
    case success = 200
    /// 用户名或密码有误
    case nameOrPassIsError = 300
    /// 用户已冻结
    case cardIsfrozen = 400
    /// 第三方平台登录：第三方平台的OPENID为空
    case thirdIdIsEmpty = 500
    /// 第三方平台的OPENID未绑定手机号
    case thirdNotBindPhone = 600
}

extension LoginState: CustomStringConvertible {
    var description: String {
        switch self {
        case .nameOrPassIsEmpty:
            return "用户名或密码为空"
        case .success:
            return "登录成功"
        case .nameOrPassIsError:
            return "用户名或密码有误"
        case .cardIsfrozen:
            return "用户已冻结"
        case .thirdIdIsEmpty:
            return "第三方平台登录：第三方平台的OPENID为空"
        case .thirdNotBindPhone:
            return "第三方平台的OPENID未绑定手机号"
        }
    }
}
