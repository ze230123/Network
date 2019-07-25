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
let provider = MoyaProvider<ApiMultiTarget>(requestClosure: requestTimeoutClosure, plugins: plugins)

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
        return provider.rx.request(ApiMultiTarget(api)).asObservable()
    }
}

extension Network {
}

extension Network {
    func getSchools(api: ApiTargetType) -> Observable<ListModel<Schools>> {
        let request = provider.rx.request(ApiMultiTarget(api)).asObservable().mapList(Schools.self).verifyStatus()
        return FirstCacheStrategy<ListModel<Schools>>(api: api, observable: request).doIt()
    }
}

import ObjectMapper

class RxCache<T: Mappable> {
    func object(_ key: String) -> T? {
        guard let object = Cache.share.cache(for: key) else {
            return nil
        }
//        print("缓存", object)
        let model = Mapper<T>().map(JSONString: object)
//        print("缓存", model)
        return model
    }
}

class CacheStrategy<T: ObjectMappable> {
    var api: ApiTargetType
    var observable: Observable<T>

    init(api: ApiTargetType, observable: Observable<T>) {
        self.api = api
        self.observable = observable
    }

    func doIt() -> Observable<T> {
        let key = api.cacheKey
        if let model = RxCache<T>().object(key) {
            return Observable<T>.just(model)
        } else {
            return observable.verifyStatus().map({ (model) in
                if let json = model.toJSONString(prettyPrint: true) {
                    Cache.share.setCache(json, key: key)
                }
                return model
            })
        }
    }
}

class FirstCacheStrategy<T: ObjectMappable> {
    var api: ApiTargetType
    var observable: Observable<T>

    init(api: ApiTargetType, observable: Observable<T>) {
        self.api = api
        self.observable = observable
    }

    func doIt() -> Observable<T> {
        let key = api.cacheKey
        let request = observable.verifyStatus().saveCache(key: key)

        guard let model = RxCache<T>().object(key) else {
            return request
        }
        return Observable<T>.just(model).concat(request).distinctUntilChanged({ (item1, item2) -> Bool in
            return item1.hash == item2.hash
        })
    }
}




extension Observable {
    static func showHud(_ block: () -> Void) -> Observable.Type {
        block()
        return Observable.self
    }
}
