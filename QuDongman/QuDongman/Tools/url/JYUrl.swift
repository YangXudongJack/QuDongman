//
//  JYUrl.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYUrl: JYUrlBase {
    class func home() -> String {
        return JYUrlBase.url()
    }
    
    class func detail(id: Int) -> String {
        return super.url().appending("/books/\(id)")
    }
    
    class func content(id: Int, chapter : Int) -> String {
        return super.url().appending("/contents/\(id)/\(chapter)")
    }
    
    class func authorCode() -> String {
        return JYUrl.construct(url: super.url_v2().appending("/member/sms"))
    }
    
    class func shortcutLogin() -> String {
        return JYUrl.construct(url: super.url_v2().appending("/member/signup"))
    }
    
    class func construct(url: String) -> String {
        var urlString = String()
        if url.contains("?") {
            urlString = url + "&sign=" + url.sign() + "&t=" + String().timestamp()
        }else{
            urlString = url + "?sign=" + url.sign() + "&t=" + String().timestamp()
        }
        return urlString
    }
}