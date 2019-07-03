//
//  Loadable.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

/// 网络请求HUD协议
protocol NetworkIndicatable: class {
    func show()
    func dismiss()
}
