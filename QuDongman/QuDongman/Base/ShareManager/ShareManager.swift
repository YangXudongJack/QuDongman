//
//  ShareManager.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/11.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

typealias ShareSuccessClosure = ()->Void

class ShareManager: NSObject, WXApiDelegate {
    static let shared = ShareManager()
    
    static let WeChatAppID:String = "wxaa3cec556b37afce"
    static let WeChatSecret:String = "f770ec753ea939b2534eae22dad2fba2"
    
    var shareSuccessClosure : ShareSuccessClosure?
    
    func shareResultClosure(closure : ShareSuccessClosure?) {
        shareSuccessClosure = closure
    }
    
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        if resp.isMember(of: SendAuthResp.self) {
            let authResp = resp as! SendAuthResp
            var requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(ShareManager.WeChatAppID)&secret=\(ShareManager.WeChatSecret)&code=\(authResp.code!)&grant_type=authorization_code"
            
            weak var weakself = self
            HttpUnit.HttpGet_Origin(url: requestUrl, responseObject: { (response) in
                let openid:String = response.value(forKey: "openid") as! String
                let access_token:String = response.value(forKey: "access_token") as! String
                
                requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=\(access_token)&openid=\(openid)"
                HttpUnit.HttpGet_Origin(url: requestUrl, responseObject: { (responseObj) in
                    HttpUnit.fastRegister(params: { () -> Dictionary<String, Any> in
                        var params:Dictionary<String, Any> = [:]
                        params["openid"] = openid
                        params["signup_type"] = "3"
                        params["userinfo"] = responseObj.value(forKey: "unionid")
                        return params
                    }, responseObject: { (responseObject, status) in
                        let data = responseObject.object(forKey: "data")
                        JYUser.shared.update(dict: data as! [String : AnyObject])
                        weakself?.shareSuccessClosure!()
                    })
                })
            })
        }
    }
}
