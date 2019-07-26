//
//  ObservableType.swift
//  Network
//
//  Created by youzy01 on 2019/7/26.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension Observable {
    /// 显示加载动画
    static func showHud(_ block: () -> Void) -> Observable.Type {
        block()
        return Observable.self
    }
}

extension ObservableType {
    /// 隐藏加载动画
    func hiddenHud(_ block: @escaping () -> Void) -> Observable<E> {
        //        return map { $0 }.do(onSubscribed: {
        //            print("onDispose")
        //            block()
        //        })
        return map { $0 }.do(onError: { (_) in
            print("onError")
            block()
        }, onCompleted: {
            print("onCompleted")
            block()
        })
    }
}

extension ObservableType where E: TestMappable {
    func verifyStatus() -> Observable<E> {
        return flatMap({ (root) -> Observable<E> in
            guard root.code == 200 else {
                return Observable.error(NetworkError.message(root.msg))
            }
            return Observable.just(root)
        })
    }
}

extension ObservableType where E: ObjectMappable {
    func verifyStatus() -> Observable<E> {
        return flatMap({ (root) -> Observable<E> in
            guard root.isSuccess else {
                return Observable.error(NetworkError.message(root.message))
            }
            return Observable.just(root)
        })
    }
}

extension Observable where Element: Response {
    func saveCache(key: String, successResult: @escaping ((Response) -> Bool)) -> Observable<Element> {
        return map({ (root) in
            if successResult(root) {
                let json = root.data.stringValue
                Cache.share.setCache(json, key: key)
            }
            return root
        })
    }
}
