//
//  CachePolicy.swift
//  Network
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

/// 缓存策略
enum CachePolicy {
    /// 不用缓存
    case none
    /// 用缓存，没有在请求网络
    case cache
    /// 先用缓存，在请求网络，得到网络数据后覆盖缓存
    case firstCache
}
