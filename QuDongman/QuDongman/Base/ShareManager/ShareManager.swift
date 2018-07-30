//
//  ShareManager.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/3/11.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

typealias ShareSuccessClosure = ()->Void

class ShareManager: NSObject, WXApiDelegate, TencentSessionDelegate {
    static let shared = ShareManager()
    
    static let WeChatAppID:String = "wx5b1ccfd1ad56c9cf"
    static let WeChatSecret:String = "b12c4f11cc893e5fc9539115a8c76e3b"
    
    static let QQAppID:String = "1106727332"
    static let QQSecret:String = "z2glGnuTreA2TO35"
    
    var shareSuccessClosure : ShareSuccessClosure?
    
    var tencentOAuth:TencentOAuth!
    
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
                        if JSONSerialization.isValidJSONObject(responseObj) {
                            let data : NSData! = try? JSONSerialization.data(withJSONObject: responseObj, options: []) as NSData!
                            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
                            params["userinfo"] = JSONString
                        }else{
                            print("unvalid object")
                        }
                        
                        return params
                    }, responseObject: { (responseObject, status) in
                        if status {
                            let data = responseObject.object(forKey: "data")
                            JYUser.shared.update(dict: data as! [String : AnyObject])
                            JYUser.shared.updateBalance()
                            weakself?.shareSuccessClosure!()
                        }
                        JYProgressHUD.dismiss()
                    })
                })
            })
        }
    }
    
    func QQDelegate() -> Void {
        tencentOAuth = TencentOAuth(appId: ShareManager.QQAppID, andDelegate: self)
    }
    
    func QQLogin() -> Void {
        ShareManager.shared.QQDelegate()
        tencentOAuth.authorize(permissions() as! [Any])
    }
    
    func permissions() -> NSMutableArray {
        return NSMutableArray.init(array: [kOPEN_PERMISSION_GET_USER_INFO,
                                           kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                           kOPEN_PERMISSION_ADD_ALBUM,
                                           kOPEN_PERMISSION_ADD_ONE_BLOG,
                                           kOPEN_PERMISSION_ADD_SHARE,
                                           kOPEN_PERMISSION_ADD_TOPIC,
                                           kOPEN_PERMISSION_CHECK_PAGE_FANS,
                                           kOPEN_PERMISSION_GET_INFO,
                                           kOPEN_PERMISSION_GET_OTHER_INFO,
                                           kOPEN_PERMISSION_LIST_ALBUM,
                                           kOPEN_PERMISSION_UPLOAD_PIC,
                                           kOPEN_PERMISSION_GET_VIP_INFO,
                                           kOPEN_PERMISSION_GET_VIP_RICH_INFO
                                            ])
    }
    
    func tencentDidLogin() -> Void {
        tencentOAuth.getUserInfo()
    }
    
    func tencentDidNotNetWork() -> Void {
        
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) -> Void {
        
    }
    
    func getUserInfoResponse(_ response: APIResponse!) {
        if response.retCode == 0 {
            weak var weakself = self
            HttpUnit.fastRegister(params: { () -> Dictionary<String, Any> in
                var params:Dictionary<String, Any> = [:]
                params["openid"] = weakself?.tencentOAuth.getUserOpenID()
                params["signup_type"] = "4"
                if JSONSerialization.isValidJSONObject(response.jsonResponse) {
                    let data : NSData! = try! JSONSerialization.data(withJSONObject: response.jsonResponse, options: []) as NSData?
                    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
                    params["userinfo"] = JSONString
                }else{
                    print("unvalid object")
                }
                
                return params
            }, responseObject: { (responseObject, status) in
                if status {
                    let data = responseObject.object(forKey: "data")
                    JYUser.shared.update(dict: data as! [String : AnyObject])
                    JYUser.shared.updateBalance()
                    weakself?.shareSuccessClosure!()
                }
            })
        } else {
            // 获取授权信息异常
        }
    }
}




















