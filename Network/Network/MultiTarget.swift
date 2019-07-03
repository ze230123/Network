//
//  MultiTarget.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import Moya

protocol ApiTargetType: TargetType {
    var encoding: ParameterEncoding { get }
    var parameters: [String: Any] { get }
}

enum MultiTarget: ApiTargetType {
    var encoding: ParameterEncoding {
        return target.encoding
    }

    var parameters: [String: Any] {
        return target.parameters
    }

    /// The embedded `TargetType`.
    case target(ApiTargetType)

    /// Initializes a `MultiTarget`.
    public init(_ target: ApiTargetType) {
        self = MultiTarget.target(target)
    }

    /// The embedded target's base `URL`.
    public var path: String {
        return target.path
    }

    /// The baseURL of the embedded target.
    public var baseURL: URL {
        return target.baseURL
    }

    /// The HTTP method of the embedded target.
    public var method: Moya.Method {
        return target.method
    }

    /// The sampleData of the embedded target.
    public var sampleData: Data {
        return target.sampleData
    }

    /// The `Task` of the embedded target.
    public var task: Task {
        return target.task
    }

    /// The `ValidationType` of the embedded target.
    public var validationType: ValidationType {
        return target.validationType
    }

    /// The headers of the embedded target.
    public var headers: [String: String]? {
        return target.headers
    }

    /// The embedded `TargetType`.
    public var target: ApiTargetType {
        switch self {
        case .target(let target): return target
        }
    }
}
