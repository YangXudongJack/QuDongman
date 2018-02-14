//
//  NSString+Net.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/24.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

extension NSString {
    
    public class func home() -> String{
        return "http://ac.xiaoshuokong.com/v1"
    }
    
    public class func detail(id : Int) -> String {
        return String.init("http://ac.xiaoshuokong.com/v1/books/\(id)")
    }
    
    public class func content(id : Int, chapter : Int) ->String {
        return String.init("http://ac.xiaoshuokong.com/v1/contents/\(id)/\(chapter)")
    }
}
