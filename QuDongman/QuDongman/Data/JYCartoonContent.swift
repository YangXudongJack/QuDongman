//
//  JYCartoonContent.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYPayData: JYBaseObject {
    @objc dynamic var title:String?
    @objc dynamic var fee:String?
    @objc dynamic var balance:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYCartoonContent: JYBaseObject {
    @objc dynamic var prev_chapter_id:String?
    @objc dynamic var next_chapter_id:String?
    @objc dynamic var pay_data:JYPayData?
    @objc dynamic var is_buy:String?
    @objc dynamic var is_vip:String?
    @objc dynamic var content_results:NSArray?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
        
        pay_data = JYPayData.init(dict: dict["pay_data"] as! [String : AnyObject])
        
    }
}
