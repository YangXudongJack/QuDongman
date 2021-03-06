//
//  HttpUnit.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/24.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import Foundation
import Alamofire

class HttpUnit: NSObject {
    
    class func HttpGet(url: String, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        HttpGet_Origin(url: url) { (response) in
            let status = response.object(forKey: "status")
            if (status as! NSString).intValue == 200 {
                let code = response.object(forKey: "code")
                responseObject(response, (code as! NSString).boolValue)
            }else{
                //error
            }
        }
    }
    
    class func HttpGet_Origin(url: String, responseObject: @escaping (_ info: NSDictionary) -> Void) -> Void {
        let _url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(_url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    if self.checkErrorCode(responseDic: dic) {
                        responseObject(dic)
                    }
                }
            }
        }
    }
    
    class func HttpPost(url: String, params: Parameters, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    if self.checkErrorCode(responseDic: dic) {
                        let status = dic.object(forKey: "status")
                        if (status as! NSString).intValue == 200 {
                            let code = dic.object(forKey: "code")
                            responseObject(json as! NSDictionary, (code as! NSString).boolValue)
                        }else{
                            print("https request failed")
                        }
                    }
                }
            }
        }
    }
    
    class func HttpPut(url: String, params: Parameters, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    if self.checkErrorCode(responseDic: dic) {
                        let status = dic.object(forKey: "status")
                        if (status as! NSString).intValue == 200 {
                            let code = dic.object(forKey: "code")
                            responseObject(json as! NSDictionary, (code as! NSString).boolValue)
                        }else{
                            print("https request failed")
                        }
                    }
                }
            }
        }
    }
    
    class func checkErrorCode(responseDic:NSDictionary) -> Bool {
        let tempValue = responseDic.object(forKey: "code")
        if tempValue == nil {
            return true
        }else{
            let code:String = tempValue as! String
            if Int(code) == 40103 {
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: String().needUpdate())))
                return false
            }else if Int(code) == 40102 {
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: String().notLogin())))
                return false
            }else if Int(code) == 40101 {
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: String().networkError())))
                return false
            }else{
                return true
            }
        }
    }
    
}
















