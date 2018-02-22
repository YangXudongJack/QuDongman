//
//  LanguageManager.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {
    func base(identifier:String) -> String {
        return NSLocalizedString(identifier, comment: "")
    }
    
    class func localized(identifier:String) -> String {
        return LanguageManager().base(identifier:identifier)
    }
}
