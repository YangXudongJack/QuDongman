//
//  JYUrlBase.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYUrlBase: NSObject {
    class func url() -> String {
        let baseUrl = String.init()
        return baseUrl.appending(self.scheme()).appending(self.address()).appending(self.versionCode())
    }
    
    class func scheme() -> String {
        return "http://"
    }
    
    class func address() -> String {
//        return "api.qudongman.com"
        return "dev.qudongman.com"
    }
    
    class func versionCode() -> String {
        return "/v2_1"
    }
}
