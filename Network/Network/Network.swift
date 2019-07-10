//
//  Network.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//
import UIKit
import Moya
import RxSwift

let requestTimeoutClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider.RequestResultClosure) in
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 30
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

var plugins: [PluginType] = [LoggerPlugin()]
let provider = MoyaProvider<MultiTarget>(requestClosure: requestTimeoutClosure, plugins: plugins)

let server = Network.share

/// 网络服务单例（添加加载动画使用）
class Network {
    static let share = Network()
    init() {
    }
}

extension Network {
    /// 显示hud动画
    func showHUD(_ block: () -> Void) -> Network {
        block()
        return self
    }

    /// 请求网络
    func request(api: ApiTargetType) -> Observable<Response> {
        return provider.rx.request(MultiTarget(api)).asObservable()
    }
}
