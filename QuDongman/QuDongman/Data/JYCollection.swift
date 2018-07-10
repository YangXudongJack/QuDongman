//
//  JYCollection.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCollection: JYBaseObject {
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    @objc dynamic var cover_image:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}
