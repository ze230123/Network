//
//  TransformerFactory.swift
//  Network
//
//  Created by youzy01 on 2019/7/24.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation

public class TransformerFactory {
    public static func forString() -> Transformer<String> {
        let toData: (String?) -> Data? = { $0?.data(using: .utf8) }
        
        let fromData: (Data?) -> String? = { $0?.toString() }
        
        return Transformer<String>(toData: toData, fromData: fromData)
    }
}
