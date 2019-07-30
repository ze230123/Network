import UIKit
import CryptoSwift

var str = "Hello, playground"


//let base = str.data(using: .utf8)?.base64EncodedString() ?? ""

//print(base)
//
//print(String(data: Data(base64Encoded: base) ?? Data(), encoding: .utf8))

let data = Data([0x01, 0x02, 0x03])
let bytes = data.bytes
let bytesHex = Array<UInt8>(hex: "0x010203")
let hexString = bytesHex.toHexString()

do {
    let aes = try AES(key: "keykeykeykeykeyk", iv: "drowssapdrowssap") // aes128
    let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
    print(ciphertext.toHexString())
} catch { }
