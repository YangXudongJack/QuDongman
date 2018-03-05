//
//  HttpUnit+Login.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/28.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation

extension HttpUnit {
    
    class func getAuthCode(number:String) -> Void{
        let url = JYUrl.authorCode()
        HttpPost(url: url, params: ["tel":number as Any], responseObject: { (response, status) in
            
        })
    }
    
    class func fastRegister(params: @escaping () -> Dictionary<String, Any>, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        let url = JYUrl.shortcutLogin()
        let parameters = params
        HttpPost(url: url, params: parameters(), responseObject: responseObject)
    }
    
    class func login(params: @escaping () -> Dictionary<String, Any>, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        let url = JYUrl.login()
        let parameters = params
        HttpPost(url: url, params: parameters(), responseObject: responseObject)
    }
}
