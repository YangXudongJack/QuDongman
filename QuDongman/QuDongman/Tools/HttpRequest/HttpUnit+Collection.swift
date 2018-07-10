//
//  HttpUnit+Collection.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation
import Alamofire

extension HttpUnit {
    class func addCollection(id:String) -> Void {
        var params:Parameters = Parameters.init()
        params["book_id"] = id
        HttpUnit.HttpPost(url: JYUrl.addCollect(), params: params) { (responseObject, success) in
            
        }
    }
    
    class func addHistory(id:String, chapter:String) -> Void {
        var params:Parameters = Parameters.init()
        params["book_id"] = id
        params["chapter_id"] = chapter
        HttpUnit.HttpPost(url: JYUrl.addHistory(), params: params) { (responseObject, success) in
            
        }
    }
}











