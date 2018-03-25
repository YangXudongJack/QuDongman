//
//  JYBanner.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYBanner: JYBaseObject {
    @objc dynamic var id:String?
    @objc dynamic var banner_image:String?
    @objc dynamic var name:String?
    @objc dynamic var hot:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}
