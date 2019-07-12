//
//  Expiry.swift
//  Network
//
//  Created by youzy01 on 2019/7/12.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

/// 过期时间
public enum Expiry {
    /// 永久
    case never
    /// 对象将在指定的秒数内过期
    case seconds(TimeInterval)
    /// 对象将在指定日期过期
    case date(Date)
}
