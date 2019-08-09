//
//  MyUDID.swift
//  Network
//
//  Created by youzy01 on 2019/8/9.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

struct MyUDID {
    func verify(code: String, uid: String) -> Bool {
        let udid = getUDID(uid: uid)
        return udid == code
    }

    func getDBPwd(uid: String) -> String {
        let str = getUDID(uid: uid) + uid
        return str.MD5.lowercased()
    }

    func getUDID(uid: String) -> String {
        let defauts = UserDefaults.standard

        var udid = defauts.string(forKey: "uid") ?? ""
        var salt = ""

        if udid.isEmpty {
            salt = UUID().uuidString.MD5
            let data = (uid.MD5 + salt).data(using: .utf8)
            udid = data?.encode.toString() ?? ""
        } else {
            udid = udid.data(using: .utf8)?.decode.toString() ?? ""
            salt = String(udid.prefix(32))
            let subUid = String(udid.prefix(32))
            let uidMd5 = uid.MD5
            if subUid == uidMd5 {
                salt = UUID().uuidString.MD5
                let data = (uid.MD5 + salt).data(using: .utf8)
                udid = data?.encode.toString() ?? ""
            } else {
                udid = udid.data(using: .utf8)?.encode.toString() ?? ""
            }
        }
        defauts.set(udid, forKey: "uid")
        return udid
    }
}
