//
//  TestStrategy.swift
//  Network
//
//  Created by youzy01 on 2019/7/26.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

/// 缓存策略实现基类
class BaseStrategy {
    fileprivate var api: ApiTargetType
    fileprivate var observable: Observable<Response>

    fileprivate var successResult: ((Response) -> Bool)!

    init(api: ApiTargetType, observable: Observable<Response>) {
        self.api = api
        self.observable = observable
    }
    // 用于判断请求是否成功
    func verifyMap(_ tran: @escaping (Response) -> Bool) -> BaseStrategy {
        successResult = tran
        return self
    }

    func run() -> Observable<Response> {
        return Observable.empty()
    }
}

/// 不使用缓存的策略实现
class NoneStrategy: BaseStrategy {
    override func run() -> Observable<Response> {
        guard RepeatHelper.share.valid(of: api.cacheKey) else {
            return Observable.error(NetworkError.reqeatCount)
        }
        RepeatHelper.share.add(api.cacheKey)
        return observable
    }
}

/// 有缓存返回缓存，没有则请求网络
class CacheStrategy: BaseStrategy {
    override func run() -> Observable<Response> {
        let key = api.cacheKey
        if let model = Cache.share.cache(for: key)?.data(using: .utf8) {
            let response = Response(statusCode: 203, data: model)
            return Observable.just(response)
        } else {
            assert(successResult != nil, "verifyMap(:) 没有调用")
            guard RepeatHelper.share.valid(of: api.cacheKey) else {
                return Observable.error(NetworkError.reqeatCount)
            }
            RepeatHelper.share.add(api.cacheKey)
            return observable.saveCache(key: key, successResult: successResult)
        }
    }
}

/// 先返回缓存，在请求网络
class FirstCacheStrategy: BaseStrategy {

    override func run() -> Observable<Response> {
        assert(successResult != nil, "verifyMap(:) 没有调用")
        func loadCache(key: String) -> Observable<Response> {
            guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
                return Observable.error(NetworkError.reqeatCount)
            }
            let response = Response(statusCode: 203, data: model)

            return Observable.just(response)
        }

        let key = api.cacheKey
        guard RepeatHelper.share.valid(of: key) else {
            return loadCache(key: key)
        }
        RepeatHelper.share.add(api.cacheKey)

        let request = observable.saveCache(key: key, successResult: successResult)

        guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
            return request
        }
        let response = Response(statusCode: 203, data: model)

        return Observable.just(response).concat(request).distinctUntilChanged({ (item1, item2) -> Bool in
            return item1.data == item2.data
        })
    }
}

/// 先请求网络，失败在返回缓存
class FirstRequestStrategy: BaseStrategy {

    override func run() -> Observable<Response> {
        func loadCache(key: String, error: Error) -> Observable<Response> {
            guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
                return Observable.error(error)
            }
            let response = Response(statusCode: 203, data: model)
            return Observable.just(response)
        }

        assert(successResult != nil, "verifyMap(:) 没有调用")

        let key = api.cacheKey

        guard RepeatHelper.share.valid(of: key) else {
            return loadCache(key: api.cacheKey, error: NetworkError.reqeatCount)
        }
        RepeatHelper.share.add(api.cacheKey)

        let request = observable.saveCache(key: key, successResult: successResult)

        return request.catchError({ (error) -> Observable<Response> in
            return loadCache(key: key, error: error)
        })
    }
}

