//
//  JYCartoon.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCartoon: JYBaseObject {
    @objc dynamic var coverImage:String?
    @objc dynamic var detailImage:String?
    @objc dynamic var title:String?
    @objc dynamic var content:NSArray?
    @objc dynamic var detail:String?
    
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}
