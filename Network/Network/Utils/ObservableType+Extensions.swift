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
    /// 开始加载动画
    ///
    /// - Parameter block: 传入执行开始动画的闭包
    /// - Returns: 返回可观察对象类型
    static func startLoading(_ block: () -> Void) -> Observable.Type {
        block()
        return Observable.self
    }
}

extension ObservableType {
    /// 停止加载动画
    ///
    /// - Parameter block: 传入执行停止动画的闭包
    /// - Returns: 返回可观察对象
    func stopLoading(_ block: @escaping () -> Void) -> Observable<E> {
        return self.do(onError: { (_) in
            block()
        }, onCompleted: {
            block()
        })
    }

    /// 出现错误时停止加载动画
    ///
    /// - Parameter block: 传入执行停止动画的闭包
    /// - Returns: 返回可观察对象
    func stopLoadingWithError(_ block: @escaping () -> Void) -> Observable<E> {
        return self.do(onError: { (_) in
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
