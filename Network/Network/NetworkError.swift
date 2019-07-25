//
//  NetworkError.swift
//  Network
//
//  Created by youzy01 on 2019/7/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case message(String)
    case failure
}
