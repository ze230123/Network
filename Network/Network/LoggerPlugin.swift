//
//  LoggerPlugin.swift
//  Network
//
//  Created by youzy01 on 2019/7/10.
//  Copyright © 2019 youzy. All rights reserved.
//

import Moya
import Result

final class LoggerPlugin: PluginType {
    var startTimes: [String: CFAbsoluteTime] = [:]

    func willSend(_ request: RequestType, target: TargetType) {
        startTimes[target.path] = CFAbsoluteTimeGetCurrent()
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            var items: [String] = []
            items.append("┌────────────────────────────────────────────────────────────────\n")
            items.append("├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄网络请求完成┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\n")
            items.append("├ 请求类型: \(response.request?.httpMethod ?? "") \n")
            items.append("├ 请求地址: \(response.request?.url?.absoluteString ?? "") \n")
            items.append("├ 响应代码: \(response.statusCode)")
            items.append("├ 发送数据: \(response.request?.httpBody?.stringValue ?? "") \n")
            items.append("├ 请求耗时: \(String(format: "%.2f", time(for: target.path)))ms \n")
            items.append("├ 服务器返回数据: \((try? response.mapString()) ?? "") \n")
            items.append("└──────────────────────────────────────────────────────────────── \n")
            outputItems(items)
        case .failure(let error):
            print(error.localizedDescription)
            //            outputError(logNetworkError(error, target: target))
        }
    }

    func time(for path: String) -> CFAbsoluteTime {
        let start = startTimes[path] ?? 0
        return (CFAbsoluteTimeGetCurrent() - start) * 1000
    }

    fileprivate func outputItems(_ items: [String]) {
        print(items.joined(separator: ""))
    }

//    fileprivate func outputError(_ items: [String]) {
//        items.forEach { Logger.error($0) }
//    }
}


/*
 请求类型: ......
 请求地址: ......
 响应代码:
 发送数据:
 请求耗时:
 服务器返回数据:
 */

extension Data {
    var stringValue: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}
