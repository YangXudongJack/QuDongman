//
//  JYHome.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYNav: JYBaseObject {
    @objc dynamic var nav_image:String?
    @objc dynamic var nav_name:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYRecommendObject: JYBaseObject {
    @objc dynamic var id:String?
    @objc dynamic var banner_image:String?
    @objc dynamic var cover_image_m:String?
    @objc dynamic var name:String?
    @objc dynamic var descp_short:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class JYRecommend: JYBaseObject {
    @objc dynamic var top_result:JYRecommendObject?
    @objc dynamic var recommend_results:NSMutableArray?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
        
        top_result = JYRecommendObject.init(dict: dict["top_result"] as! [String : AnyObject])
        
        let recommend_results_array:Array<NSDictionary> = dict["book_results"] as! Array
        recommend_results = NSMutableArray()
        for item in recommend_results_array {
            recommend_results?.add(JYRecommendObject.init(dict: item as! [String : AnyObject]))
        }
    }
}

class JYHome: JYBaseObject {
    @objc dynamic var recommend_results:NSMutableArray?
    @objc dynamic var banner_results:NSMutableArray?
    @objc dynamic var nav_results:NSMutableArray?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
        
        let recommend_results_array:Array<NSDictionary> = dict["recommend_results"] as! Array
        recommend_results = NSMutableArray()
        for item in recommend_results_array {
            recommend_results?.add(JYRecommend.init(dict: item as! [String : AnyObject]))
        }
        
        let banner_results_array:Array<NSDictionary> = dict["banner_results"] as! Array
        banner_results = NSMutableArray()
        for item in banner_results_array {
            banner_results?.add(JYRecommendObject.init(dict: item as! [String : AnyObject]))
        }
        
        let nav_results_array:Array<NSDictionary> = dict["nav_results"] as! Array
        nav_results = NSMutableArray()
        for item in nav_results_array {
            nav_results?.add(JYNav.init(dict: item as! [String : AnyObject]))
        }
    }
}
