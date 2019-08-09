//
//  TestAPI.swift
//  Network
//
//  Created by youzy01 on 2019/7/4.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import Moya

enum TestAPI {
    case new
}

extension TestAPI: ApiTargetType {
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var parameters: [String : Any] {
        return ["type": 1, "page": 1]
    }

    var policy: CachePolicy {
        switch self {
        default:
            return .none
        }
    }

    var baseURL: URL {
        return URL(string: "https://www.apiopen.top")!
    }

    var path: String {
        return "satinApi"
//        return "satinApis"
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var headers: [String : String]? {
        return nil
    }
}
