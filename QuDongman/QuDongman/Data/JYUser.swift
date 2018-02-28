//
//  JYUser.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYUser: JYBaseObject {
    @objc dynamic var username:String?
    @objc dynamic var id:String?
    @objc dynamic var access_token:String?
    @objc dynamic var avatar:String?
    
    static let shared = JYUser.init(dict: [:])
    
    private override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
    }
    
    func update(dict:[String:AnyObject]) -> Void {
        setValuesForKeys(dict)
    }
}
