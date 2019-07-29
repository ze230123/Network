//
//  NetworkError.swift
//  Network
//
//  Created by youzy01 on 2019/7/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case message(String)
    case failure
    case reqeatCount
    case noCache

}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .message(let msg):
            return msg
        case .failure:
            return "网络连接失败"
        case .reqeatCount:
            return "请求过于频繁，请稍后再试"
        case .noCache:
            return "未找到缓存,请连接网络后重试"
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        return description
    }
}
