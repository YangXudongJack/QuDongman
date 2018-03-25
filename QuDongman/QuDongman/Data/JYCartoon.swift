//
//  JYCartoon.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/2/17.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYBookInfo: JYBaseObject {
    @objc dynamic var descp:String?
    @objc dynamic var name:String?
    @objc dynamic var issuer:String?
    @objc dynamic var cover_image:String?
    @objc dynamic var tag_results:Array<Any>?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYCatelog: JYBaseObject {
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYCartoon: JYBaseObject {
    var book_reesult:JYBookInfo?
    var chapter_results:Array<Any>?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        
        book_reesult = JYBookInfo.init(dict: dict["book_result"] as! [String : AnyObject])
        
        chapter_results = Array()
        let chapters:Array<NSDictionary> = dict["chapter_results"] as! Array
        for item:NSDictionary in chapters {
            chapter_results?.append(JYCatelog.init(dict: item as! [String : AnyObject]))
        }
    }
}
