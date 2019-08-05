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

/// 判断response中服务器返回数据状态
///
/// 此方法根据服务器实际返回的数据做判断
func responseIsSuccess(_ response: Response) -> Bool {
    guard let json = try? response.mapString() else {
        return false
    }
    guard let item = ResponseVerify(JSONString: json) else {
        return false
    }
    return item.isSuccess
}

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

var plugins: [PluginType] = [NewLoggerPlugin()]
let provider = MoyaProvider<ApiMultiTarget>(requestClosure: requestTimeoutClosure, plugins: plugins)

let server = HttpServer.share

/// 网络服务单例（添加加载动画使用）
class HttpServer {
    static let share = HttpServer()
    init() {
    }
}

extension HttpServer {
    /// 显示hud动画
    func showHUD(_ block: () -> Void) -> HttpServer {
        block()
        return self
    }

    /// 请求网络
    ///
    /// 缓存策略已添加，数据转换需要外部处理
    func request(api: ApiTargetType) -> Observable<Response> {
        let request = provider.rx.request(ApiMultiTarget(api)).asObservable()
        let strategy = api.policy.stratey(api: api, observable: request)
        return strategy.verifyMap(responseIsSuccess(_:)).run()
    }
}

extension HttpServer {
    /// 封装好的接口方法，接口缓存、模型转换都已处理完毕，外部订阅后可直接使用模型
    func getSchools(api: ApiTargetType) -> Observable<ListModel<Schools>> {
        let request = provider.rx.request(ApiMultiTarget(api)).asObservable()
        let strategy = api.policy.stratey(api: api, observable: request)
        return strategy.verifyMap(responseIsSuccess(_:)).run().mapList(Schools.self).verifyStatus()
    }
}
