//
//  JYUser.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYUser: JYBaseObject {
    static let JYUserData = "JYUserData"
    
    @objc dynamic var username:String?
    @objc dynamic var id:String?
    @objc dynamic var balance:String?
    @objc dynamic var nickname:String?
    @objc dynamic var access_token:String?
    @objc dynamic var avatar:String?
    
    static let shared = JYUser.init(dict: [:])
    
    private override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
    }
    
    func update(dict:[String:AnyObject]) -> Void {
        setValuesForKeys(dict)
        
        saveUserData()
    }
    
    func userData() -> Dictionary<String, AnyObject> {
        var user = Dictionary<String, AnyObject>()
        var balance:AnyObject
        if self.balance == nil {
            balance = "" as AnyObject
        }else{
            balance = self.balance as AnyObject
        }
        
        var avatar:AnyObject
        if self.avatar == nil {
            avatar = "" as AnyObject
        }else{
            avatar = self.avatar as AnyObject
        }
        
        var nickname:AnyObject
        if self.nickname == nil {
            nickname = "" as AnyObject
        }else{
            nickname = self.nickname as AnyObject
        }
        
        user["username"] = self.username as AnyObject
        user["id"] = self.id as AnyObject
        user["balance"] = balance
        user["balance"] = nickname
        user["access_token"] = self.access_token as AnyObject
        user["avatar"] = avatar
        
        return user
    }
    
    func saveUserData() -> Void {
        UserDefaults.standard.set(userData(), forKey: JYUser.JYUserData)
    }
    
    class func exist() -> Bool {
        let user = UserDefaults.standard.object(forKey: JYUser.JYUserData)
        if user == nil {
            return false
        }else{
            JYUser.shared.update(dict: user as! [String : AnyObject])
            JYUser.shared.updateBalance()
            return true
        }
    }
    
    func updateBalance() -> Void {
//        let semaphore = DispatchSemaphore.init(value: 0)
        HttpUnit.HttpGet(url: JYUrl.userInfo()) { (response, success) in
            JYUser.shared.update(dict: response.object(forKey: "data") as! [String : AnyObject])
//            semaphore.signal()
        }
//        semaphore.wait()
    }
    
    func clear(colsure:()->Void) -> Void {
        username = nil
        id = nil
        balance = nil
        nickname = nil
        access_token = nil
        avatar = nil
        
        if colsure != nil {
            colsure()
        }
    }
}




















