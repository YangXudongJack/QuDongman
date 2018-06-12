//
//  JYCategory.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCategory: JYBaseObject {
    @objc dynamic var cat_id:String?
    @objc dynamic var cat_name:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}
