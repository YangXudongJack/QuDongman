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
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    let status = dic.object(forKey: "status")
                    responseObject(json as! NSDictionary, (status as! NSString).boolValue)
                }
            }
        }
    }
    
    class func HttpPost(url: String, params: Dictionary<String, Any>, responseObject: @escaping (_ info: NSDictionary, _ status: Bool) -> Void) -> Void {
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                if let json = response.result.value {
                    let dic : NSDictionary = json as! NSDictionary
                    let status = dic.object(forKey: "status")
                    responseObject(json as! NSDictionary, (status as! NSString).boolValue)
                }
            }
        }
    }
    
}
















