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
    @objc dynamic var is_vip:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYCommentMember: JYBaseObject {
    @objc dynamic var avatar:String?
    @objc dynamic var nickname:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYComment: JYBaseObject {
    @objc dynamic var to_member_id:String?
    @objc dynamic var content:String?
    @objc dynamic var member_result:JYCommentMember?
    @objc dynamic var id:String?
    @objc dynamic var created_at:String?
    @objc dynamic var member_id:String?
    @objc dynamic var comment_count:String?
    @objc dynamic var to_member_result:JYCommentMember?
    @objc dynamic var pid:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
        
        member_result = JYCommentMember.init(dict: dict["member_result"] as! [String : AnyObject])
        to_member_result = JYCommentMember.init(dict: dict["to_member_result"] as! [String : AnyObject])
    }
}

class JYPartComments: JYBaseObject {
    @objc dynamic var count:String?
    @objc dynamic var results:NSMutableArray?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        
        count = dict["count"] as? String
        
        results = NSMutableArray()
        let results_dic = dict["results"]
        if (results_dic?.isKind(of: NSArray.self))! {
            let results_arr:NSArray = results_dic as! NSArray
            for item in results_arr {
                results?.add(JYComment.init(dict: item as! [String : AnyObject]))
            }
        }
    }
}

class JYCartoon: JYBaseObject {
    var book_reesult:JYBookInfo?
    var chapter_results:Array<Any>?
    var comment_results:JYPartComments?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        
        book_reesult = JYBookInfo.init(dict: dict["book_result"] as! [String : AnyObject])
        
        chapter_results = Array()
        let chapters:Array<NSDictionary> = dict["chapter_results"] as! Array
        for item:NSDictionary in chapters {
            chapter_results?.append(JYCatelog.init(dict: item as! [String : AnyObject]))
        }
        
        comment_results = JYPartComments.init(dict: dict["comment_results"] as! [String : AnyObject])
    }
}
