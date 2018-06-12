//
//  JYUserBuyCoin.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/4/21.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYProduct: JYBaseObject {
    @objc dynamic var id:String?
    @objc dynamic var total_fee:String?
    @objc dynamic var product_name:String?
    @objc dynamic var balance:String?
    @objc dynamic var total_fee_descp:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}
