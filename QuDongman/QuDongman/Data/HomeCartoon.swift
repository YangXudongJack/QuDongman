//
//  HomeCartoon.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/24.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class HomeCartoon: NSObject {

    var id:String?
    var banner_image:String?
    
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
