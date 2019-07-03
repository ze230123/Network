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
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        let json = try mapString()
        guard let object = Mapper<T>(context: context).map(JSONString: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}

extension ObservableType where E == Response {
    // ResultModel 根据需要替换
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ResultModel<T>> {
        return map { (response) in
            return try response.mapObject(ResultModel<T>.self, context: context)
        }
    }

    func mapList<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ListModel<T>> {
        return map { (response) in
            return try response.mapObject(ListModel<T>.self, context: context)
        }
    }
}
