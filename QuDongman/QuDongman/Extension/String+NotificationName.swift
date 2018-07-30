//
//  String+NotificationName.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation

extension String {
    
    func publicName() -> String {
        return "JYNotificationName_"
    }
    
    func notLogin() -> String {
        return self.publicName() + "NotLogin"
    }
    
    func needUpdate() -> String {
        return self.publicName() + "NeedUpdate"
    }
    
    func networkError() -> String {
        return self.publicName() + "NetWorkError"
    }
}













