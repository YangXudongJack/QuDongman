//
//  String+Method.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/16.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import Foundation

extension String {
    func to_vx(old_v:String, new_v:String) -> String {
        return self.replacingOccurrences(of: old_v, with: new_v)
    }
    
    func to_v2_1(old_v:String) -> String {
        return self.to_vx(old_v: old_v, new_v: "v2_1/")
    }
    
    func v2_to_v2_1() -> String {
        return self.to_v2_1(old_v: "v2/")
    }
    
    func to_v2_2(old_v:String) -> String {
        return self.to_vx(old_v: old_v, new_v: "v2_2/")
    }
    
    func v2_to_v2_2() -> String {
        return self.to_v2_2(old_v: "v2/")
    }
    
    func m_home() -> String {
        return "v2/default/index".v2_to_v2_2()
    }
    
    func m_detail() -> String {
        return "v2/book/view".v2_to_v2_2()
    }
    
    func m_content() -> String {
        return "v2/content/view".v2_to_v2_2()
    }
    
    func m_sms() -> String {
        return "v2/default/sms".v2_to_v2_1()
    }
    
    func m_signUp() -> String {
        return "v2/default/signup".v2_to_v2_1()
    }
    
    func m_signIn() -> String {
        return "v2/default/signin".v2_to_v2_1()
    }
    
    func m_products() -> String {
        return "v2/product/index".v2_to_v2_1()
    }
    
    func m_comments() -> String {
        return "v2_1/comment/index".v2_to_v2_1()
    }
    
    func m_addComments() -> String {
        return "v2_1/comment/create".v2_to_v2_1()
    }
    
    func m_pay() -> String {
        return "v2/pay/unifiedorder".v2_to_v2_1()
    }
    
    func m_userInfo() -> String {
        return "v2_1/member/view".v2_to_v2_1()
    }
    
    func m_recharge() -> String {
        return "v2/behavior/index".v2_to_v2_1()
    }
    
    func m_category() -> String {
        return "v2_1/category/index"
    }
    
    func m_search() -> String {
        return "v2_1/search/index"
    }
    
    func m_collect() -> String {
        return "v2_1/collection/index"
    }
    
    func m_addCollect() -> String {
        return "v2_1/collection/create"
    }
    
    func m_history() -> String {
        return "v2_1/history/index"
    }
    
    func m_addHistory() -> String {
        return "v2_1/history/create"
    }
    
    func m_updateUserInfo() -> String {
        return "v2_1/member/update"
    }
    
}










