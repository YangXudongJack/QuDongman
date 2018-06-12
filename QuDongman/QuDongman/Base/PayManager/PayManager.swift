//
//  PayManager.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/4/30.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit
import Alamofire

enum PayType {
    case ali
    case wechat
}

class PayManager: NSObject {
    static let shared = PayManager()
    static let aliHost:String = "safepay"
    
    func pay(type:PayType, product:JYProduct) -> Void {
        var params:Parameters = Parameters.init()
        params["pay_type"] = (type == .ali ? "20" : "10")
        params["order_type"] = "1"
        params["product_id"] = product.id
        
        weak var weakself = self
        if type == .ali {
            HttpUnit.HttpPost(url: JYUrl.preparePay(), params: params) { (response, status) in
                if status {
                    let data = response.object(forKey: "data")
                    let order:JYOrder = JYOrder.init(dict: data as! [String : AnyObject])
                    weakself?.aliPay(order: order)
                }
            }
        }else{
            
        }
    }
    
    func aliPay(order:JYOrder) -> Void {
        order.orderInfo { (orderInfoEncoded, signString) in
            let string:String = orderInfoEncoded + "&sign=" + signString
            AlipaySDK.defaultService().payOrder(string, fromScheme: "AliPay20180506", callback: { (dictionary) in
                
            })
        }
    }
}
