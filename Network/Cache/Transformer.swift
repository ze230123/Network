//
//  Transformer.swift
//  Network
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

public class Transformer<T> {
    let toData: (T?) -> Data?
    let fromData: (Data?) -> T?

    public init(toData: @escaping (T?) -> Data?, fromData: @escaping (Data?) -> T?) {
        self.toData = toData
        self.fromData = fromData
    }
}
