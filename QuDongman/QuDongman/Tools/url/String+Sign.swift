//
//  String+Sign.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation

let app_key = "892aa040b7d8d9dc3b00ea14e2a284d4"

extension String {
    func sign() -> String {
        let method = "v2/" + self.components(separatedBy: "/v2/").last!
        let signString = "app_key=\(app_key)method=\(method)t=\(self.timestamp())"
        return signString.md5()
    }
    
    func timestamp() -> String {
        let timeInterval = Date().timeIntervalSince1970 * 1000
        return "\(Int64(timeInterval))"
    }
    
    func md5() -> String {
        #if DEBUG
            return "lc"
        #else
            let str = self.cString(using: String.Encoding.utf8)
            let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_MD5(str!, strLen, result)
            let hash = NSMutableString()
            for i in 0 ..< digestLen {
                hash.appendFormat("%02x", result[i])
            }
            result.deinitialize()
            
            return String(format: hash as String)
        #endif
    }
}
