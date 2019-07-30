//
//  Date+Extensions.swift
//  Network
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

/**
 Helper NSDate extension.
 */
extension Date {

    /// 检查日期是否过期
    /// Checks if the date is in the past.
    var inThePast: Bool {
        return timeIntervalSinceNow < 0
    }
}
