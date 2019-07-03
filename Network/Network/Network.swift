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
        //                urlRequest.timeoutInterval = timeoutInterval
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

var plugins: [PluginType] = [NetworkLoggerPlugin()]
let provider = MoyaProvider<MultiTarget>(requestClosure: requestTimeoutClosure, plugins: plugins)

class Network {
    var vc: NetworkIndicatable?

    let signingIn: Observable<Bool>

    let indicator = ActivityIndicator()
    init() {
        signingIn = indicator.asObservable()
    }
}

extension Network {
    func showHUD() -> Network {
        vc?.show()
        return self
    }

    func request(api: ApiTargetType) -> Observable<Response> {
        return provider.rx.request(MultiTarget(api)).asObservable().trackActivity(indicator)
    }
}
