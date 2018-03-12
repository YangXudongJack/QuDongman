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
            responseObject(response, (status as! NSString).boolValue)
        }
    }
    
    class func HttpGet_Origin(url: String, responseObject: @escaping (_ info: NSDictionary) -> Void) -> Void {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    responseObject(dic)
                }
            }
        }
    }
    
    class func HttpPost(url: String, params: Parameters, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
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
















