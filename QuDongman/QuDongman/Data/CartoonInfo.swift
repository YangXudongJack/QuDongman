//
//  CartoonInfo.swift
//  QuDongman
//
//  Created by 杨旭东 on 01/11/2017.
//  Copyright © 2017 JackYang. All rights reserved.
//

import UIKit

class CartoonInfo: NSObject {
    var coverImage:String?
    var detailImage:String?
    var title:String?
    var content:NSArray?
    var detail:String?
    
    
    init (dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        super.setValuesForKeys(keyedValues)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
