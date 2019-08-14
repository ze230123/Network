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
            print("udid 为空")
            salt = UUID().uuidString.MD5
            let data = (uid.MD5 + salt).data(using: .utf8)
            udid = data?.encode.toString() ?? ""
        } else {
            print("udid 有值")
            udid = decodeUdid(udid)
            print(udid)
            print(uid.MD5)
            salt = String(udid.suffix(32))
            print(salt)
            let subUid = String(udid.prefix(32))
            let uidMd5 = uid.MD5
            if subUid != uidMd5 {
                print("重新生成")
                salt = UUID().uuidString.MD5
                let data = (uid.MD5 + salt).data(using: .utf8)
                udid = data?.encode.toString() ?? ""
            } else {
                print("重新加密")
                udid = udid.data(using: .utf8)?.encode.toString() ?? ""
            }
        }
        defauts.set(udid, forKey: "uid")
        return salt
    }

    func salt() -> String {
        return UUID().uuidString.MD5
    }

    func encodeUdid(uid: String) -> String {
        let data = (uid.MD5 + salt()).data(using: .utf8)
        return data?.encode.toString() ?? ""
    }

    func decodeUdid(_ udid: String) -> String {
        return udid.data(using: .utf8)?.decode.toString() ?? ""
    }
}
