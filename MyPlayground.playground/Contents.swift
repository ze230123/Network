import UIKit

private let encrypt_vil: [UInt8] = [
    65, 68, 54, 52, 65, 53, 69, 48,
    52, 56, 57, 57, 69, 56, 56, 69,
    68, 48, 70, 55, 70, 50, 49, 51,
    65, 52, 68, 69, 54, 65, 53, 48
]

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    var encode: Data {
        var bytes: [UInt8] = []
        for (idx, str) in self.enumerated() {
            let temp = str ^ encrypt_vil[idx % encrypt_vil.count]
            bytes.append(temp)
        }
        let data = Data(bytes).base64EncodedData()
        return data
    }
    
    var decode: Data {
        guard let newData = Data(base64Encoded: self) else {
            return Data()
        }
        var bytes: [UInt8] = []
        for (idx, str) in newData.enumerated() {
            let temp = str ^ encrypt_vil[idx % encrypt_vil.count]
            bytes.append(temp)
        }
        return Data(bytes)
    }
}

//if let data = "哈哈".data(using: .utf8) {
//    let base64 = writer(json: data)
//    load(data: base64)
//}

let test = "哈哈"

let base64 = test.data(using: .utf8)?.encode ?? Data()

print(String(data: base64, encoding: .utf8) ?? "")

let result = base64.decode.toString() ?? ""

print(result)
