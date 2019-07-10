//
//  Response+Map.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

extension Response {
    /// 转换模型
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        let json = try mapString()
        guard let object = Mapper<T>(context: context).map(JSONString: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}

extension ObservableType where E == Response {
    /// JSON转模型
    ///
    /// ResultModel 可根据需要替换
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ResultModel<T>> {
        return map { (response) in
            return try response.mapObject(ResultModel<T>.self, context: context)
        }
    }

    /// JSON转模型数组
    ///
    /// ListModel 可根据需要替换
    func mapList<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ListModel<T>> {
        return map { (response) in
            return try response.mapObject(ListModel<T>.self, context: context)
        }
    }

    /// JSON转String模型（var result: String）
    ///
    /// ResultModel 可根据需要替换
    func mapStringModel() -> Observable<StringModel> {
        return map { (response) in
            return try response.mapObject(StringModel.self, context: nil)
        }
    }

    /// 测试使用
    func testMap<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<RootClass<T>> {
        return map { (response) in
            return try response.mapObject(RootClass<T>.self, context: context)
        }
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
