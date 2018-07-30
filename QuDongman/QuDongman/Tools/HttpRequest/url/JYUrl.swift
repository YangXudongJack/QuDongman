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
        return JYUrl.construct(url: super.url().to_v(v: "v2_2").appending("?pre-page=0&page=\(page)"), method: String().m_home())
    }
    
    class func detail(id: Int) -> String {
        return JYUrl.construct(url: super.url().to_v(v: "v2_2").appending("/books/\(id)?id=\(id)"), method: String().m_detail())
    }
    
    class func content(id: Int, chapter : Int) -> String {
        if JYUser.exist() {
            let token:String = JYUser.shared.access_token!
            let userid:String = JYUser.shared.id!
            return JYUrl.construct(url: super.url().to_v(v: "v2_2").appending("/contents/\(id)/\(chapter)?member_id=\(userid)&access_token=\(token)"), method: String().m_content())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func authorCode() -> String {
        return JYUrl.construct(url: super.url().appending("/default/sms"), method: String().m_sms())
    }
    
    class func shortcutLogin() -> String {
        return JYUrl.construct(url: super.url().appending("/default/signup"), method: String().m_signUp())
    }
    
    class func login() -> String {
        return JYUrl.construct(url: super.url().appending("/default/signin"), method: String().m_signIn())
    }
    
    class func product() -> String {
        return JYUrl.construct(url: super.url().appending("/products?pre-page=0&page=0"), method: String().m_products())
    }
    
    class func comments(page:Int, bookId:String, chapter:String, pid:String) -> String {
        var url = super.url().appending("/comments?pre-page=0&page=\(page)&book_id=\(bookId)&chapter_id=\(chapter)&pid=\(pid)")
        if JYUser.exist() {
            let token:String = JYUser.shared.access_token!
            let id:String = JYUser.shared.id!
            url.append("&member_id=\(id)&access_token=\(token)")
        }
        return JYUrl.construct(url: url, method: String().m_comments())
    }
    
    class func addComments() -> String {
        if JYUser.exist() {
            let token:String = JYUser.shared.access_token!
            let id:String = JYUser.shared.id!
            return JYUrl.construct(url: super.url().appending("/comments?member_id=\(id)&access_token=\(token)"), method: String().m_addComments())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func preparePay() -> String {
        if JYUser.exist() {
            let token:String = JYUser.shared.access_token!
            let id:String = JYUser.shared.id!
            return JYUrl.construct(url: super.url().appending("/pay/unifiedorder?member_id=\(id)&access_token=\(token)"), method: String().m_pay())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func userInfo() -> String {
        let id:String = JYUser.shared.id!
        let token:String = JYUser.shared.access_token!
        return JYUrl.construct(url: super.url().appending("/members/\(id)?member_id=\(id)&access_token=\(token)"), method: String().m_userInfo())
    }
    
    class func record(isShopping: Bool) -> String{
        if isShopping {
            return self.shopping()
        }else{
            return self.recharge()
        }
    }
    
    class func recharge() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/behaviors?member_id=\(id)&access_token=\(token)&pre-page=0&page=0&btype=10"), method: String().m_recharge())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func shopping() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/behaviors?member_id=\(id)&access_token=\(token)&pre-page=0&page=0&btype=11"), method: String().m_recharge())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func category() -> String {
        return JYUrl.construct(url: super.url().appending("/categories?pre-page=0&page=0"), method: String().m_category())
    }
    
    class func search(page:Int, key:String, cat_id:String, finish_status:String, sort:String) -> String {
        return JYUrl.construct(url: super.url().appending("/searches?pre-page=0&page=\(page)&k=\(key)&cat_id=\(cat_id)&finish_status=\(finish_status)&sort=\(sort)"), method: String().m_search())
    }
    
    class func addCollect() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/collections?member_id=\(id)&access_token=\(token)"), method: String().m_addCollect())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func collect() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/collections?member_id=\(id)&access_token=\(token)&pre-page=15&page=0"), method: String().m_collect())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func addHistory() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/historys?member_id=\(id)&access_token=\(token)"), method: String().m_addHistory())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func history() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/historys?member_id=\(id)&access_token=\(token)&pre-page=15&page=0"), method: String().m_history())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func buyChapter() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/member/behaviors?member_id=\(id)&access_token=\(token)"), method: String().m_history())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func updateUserInfo() -> String {
        if JYUser.exist() {
            let id:String = JYUser.shared.id!
            let token:String = JYUser.shared.access_token!
            return JYUrl.construct(url: super.url().appending("/members/\(id)?member_id=\(id)&access_token=\(token)"), method: String().m_updateUserInfo())
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: String().notLogin()), object: nil)
            return String()
        }
    }
    
    class func construct(url: String, method: String) -> String {
        var urlString = String()
        let timestamp = String().timestamp()
        if url.contains("?") {
            urlString = url + "&sign=" + (url + "&t=" + timestamp).sign(method: method) + "&t=" + timestamp
        }else{
            urlString = url + "?sign=" + (url + "?t=" + timestamp).sign(method: method) + "&t=" + timestamp
        }
        return urlString
    }
}
