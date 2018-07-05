//
//  JYUrl.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYUrl: JYUrlBase {
    class func home(page : Int) -> String {
        return JYUrl.construct(url: super.url().appending("?pre-page=0&page=\(page)"))
    }
    
    class func detail(id: Int) -> String {
        return JYUrl.construct(url: super.url().appending("/books/\(id)"))
    }
    
    class func content(id: Int, chapter : Int) -> String {
        return JYUrl.construct(url: super.url().appending("/contents/\(id)/\(chapter)"))
    }
    
    class func authorCode() -> String {
        return JYUrl.construct(url: super.url().appending("/default/sms"))
    }
    
    class func shortcutLogin() -> String {
        return JYUrl.construct(url: super.url().appending("/default/signup"))
    }
    
    class func login() -> String {
        return JYUrl.construct(url: super.url().appending("/default/signin"))
    }
    
    class func product() -> String {
        return JYUrl.construct(url: super.url().appending("/products?pre-page=0&page=0"))
    }
    
    class func preparePay() -> String {
        let token:String = JYUser.shared.access_token!
        let id:String = JYUser.shared.id!
        return JYUrl.construct(url: super.url().appending("/pay/unifiedorder?member_id=\(id)&access_token=\(token)"))
    }
    
    class func userInfo() -> String {
        let id:String = JYUser.shared.id!
        let token:String = JYUser.shared.access_token!
        return JYUrl.construct(url: super.url().appending("/members/\(id)?member_id=\(id)&access_token=\(token)"))
    }
    
    class func record(isShopping: Bool) -> String{
        if isShopping {
            return self.shopping()
        }else{
            return self.recharge()
        }
    }
    
    class func recharge() -> String {
        let id:String = JYUser.shared.id!
        let token:String = JYUser.shared.access_token!
        return JYUrl.construct(url: super.url().appending("/member/behaviors?member_id=\(id)&access_token=\(token)&pre-page=0&page=0&btype=10"))
    }
    
    class func shopping() -> String {
        let id:String = JYUser.shared.id!
        let token:String = JYUser.shared.access_token!
        return JYUrl.construct(url: super.url().appending("/member/behaviors?member_id=\(id)&access_token=\(token)&pre-page=0&page=0&btype=11"))
    }
    
    class func category() -> String {
        return JYUrl.construct(url: super.url().appending("/categories?pre-page=0&page=0"))
    }
    
    class func search(page:Int, key:String, cat_id:String, finish_status:String, sort:String) -> String {
        return JYUrl.construct(url: super.url().appending("/searches?pre-page=0&page=\(page)&k=\(key)&cat_id=\(cat_id)&finish_status=\(finish_status)&sort=\(sort)"))
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
