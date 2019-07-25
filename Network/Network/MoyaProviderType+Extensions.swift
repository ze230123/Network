//
//  MoyaProviderType+Extensions.swift
//  Network
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public extension Reactive where Base: MoyaProviderType {
    
//    /// Designated request-making method.
//    ///
//    /// - Parameters:
//    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
//    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
//    /// - Returns: Single response object.
//    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
//        return Single.create { [weak base] single in
//            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
//                switch result {
//                case let .success(response):
//                    single(.success(response))
//                case let .failure(error):
//                    single(.error(error))
//                }
//            }
//
//            return Disposables.create {
//                cancellableToken?.cancel()
//            }
//        }
//    }
//
//    func cacheRequest(_ target: Base.Target) -> Observable<Response> {
//        // 转换自定义API
//        guard let api = target as? ApiMultiTarget else {
//            return request(target).asObservable()
//        }
////        Observable.just(response).concat(originRequest)
//        //        Logger.debug(api.cacheKey)
////        switch api.policy {
////        case .none:
//////            return request(target, cacheKey: api.cacheKey)
////        case .cache:
//////            return cacheOrRequest(target, cacheKey: api.cacheKey)
////        case .firstCache:
//////            return cacheAndRequest(target, cacheKey: api.cacheKey)
////        }
//    }
//
//    /// 请求网络
//    func request(_ token: Base.Target) -> Observable<Response> {
//        return Observable.create { [weak base] single in
//            let cancellableToken = base?.request(token, callbackQueue: nil, progress: nil) { result in
//                switch result {
//                case let .success(response):
//                    single.onNext(response)
//                    single.onCompleted()
//                case .failure(let error):
////                    Logger.error(error)
//                    single.onError(NetworkError.failure)
//                }
//            }
//            return Disposables.create {
//                print("取消请求", token.path)
//                cancellableToken?.cancel()
//            }
//        }
//    }
////
//    /// 请求真实网络数据，判断接口调用次数
//    func request(_ token: Base.Target, cacheKey: String) -> Observable<Response> {
//        guard RepeatHelper.shared.canRequest(cacheKey) else {
//            return Observable.create { single in
//                single.onError(ServerError.repeatLimit)
//                single.onCompleted()
//                return Disposables.create()
//            }
//        }
//        return request(token)
//    }
//
//    /// 有缓存则先返回缓存，在请求网络返回网络数据，并更新缓存
//    func cacheAndRequest(_ target: Base.Target, cacheKey: String) -> Observable<Response> {
//        var originRequest = request(target).filterSuccessfulStatusCodes()
//        var cacheResponse: Response?
//
//        cacheResponse = ZECache.shard.fetchResponseCache(key: cacheKey)
//
//        originRequest = originRequest.map { (response) -> Response in
//            //            guard jsonString.statusCode == 200 else {
//            //                return jsonString
//            //            }
//            if (try? response.code()) != nil {
//                ZECache.shard.cacheResponse(response, key: cacheKey)
//            }
//
//            //            if let item = ((try? response.code()) as Any??), item != nil {
//            //                ZECache.shard.cacheResponse(response, key: cacheKey)
//            //            }
//            //            ZECache.shard.cacheResponse(jsonString, key: cacheKey)
//            return response
//        }
//
//        // 判断有无缓存
//        guard let response = cacheResponse else {
//            return originRequest
//        }
//
//        // 有缓存先返回缓存，在返回真实请求
//        return Observable.just(response).concat(originRequest)
//    }
//
//    /// 有缓存就返回缓存，没有在请求网络
//    func cacheOrRequest(_ target: Base.Target, cacheKey: String) -> Observable<Response> {
//        var cacheResponse: Response?
//
//        // 查找缓存
//        cacheResponse = ZECache.shard.fetchResponseCache(key: cacheKey)
//
//        // 判断有无缓存，有则直接返回缓存，无则请求网络并更新缓存
//        guard let canche = cacheResponse else {
//            let originRequest = request(target).map { (response) -> Response in
//                if (try? response.code()) != nil {
//                    ZECache.shard.cacheResponse(response, key: cacheKey)
//                }
//                //                if let item = ((try? response.code()) as Any??), item != nil {
//                ////                    let url = response.request?.url?.absoluteString ?? ""
//                ////                    Logger.debug("\(try? response.code()) \(url) key: \(cacheKey) 缓存: \(try? response.mapString())")
//                //                    ZECache.shard.cacheResponse(response, key: cacheKey)
//                //                }
//                // 更新缓存
//                return response
//            }
//            return originRequest
//        }
//        return Observable.just(canche)
//    }
}
