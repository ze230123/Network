//
//  UserInfo.swift
//  Network
//
//  Created by youzy01 on 2019/7/9.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

struct UserInfo {
    var user: User?
    var score: Score?
    var isGaokao: Bool = false

    init() {
    }

    init(user: User) {
        self.user = user
    }

    init(score: Score) {
        self.score = score
    }

    init(user: User, score: Score) {
        self.user = user
        self.score = score
    }
}
