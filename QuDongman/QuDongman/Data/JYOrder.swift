//
//  JYOrder.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/4.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYOrder: JYBaseObject {
    
    static let AliAppID:String = "2018020602152576"

    @objc dynamic var total_fee:String?
    @objc dynamic var body_desc:String?
    @objc dynamic var out_trade_no:String?
    @objc dynamic var notify_url:String?
    @objc dynamic var rsa:String?
    
    override init (dict:[String:AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
    
    func orderInfo(colsure:(String, String) -> Void) -> Void {
        let order:APOrderInfo = APOrderInfo.init()
        order.app_id = JYOrder.AliAppID
        order.method = "alipay.trade.app.pay"
        order.charset = "utf-8"

        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        order.timestamp = formatter.string(from: Date.init())
        order.version = "1.0"
        order.sign_type = "RSA2"
        order.notify_url = notify_url
        
        // NOTE: 商品数据
        order.biz_content = APBizContent.init()
        order.biz_content.subject = body_desc
        order.biz_content.out_trade_no = out_trade_no
        order.biz_content.total_amount = total_fee
        order.biz_content.product_code = "QUICK_MSECURITY_PAY"
        
        let orderString = order.orderInfoEncoded(false)
        let orderStringEncoded = order.orderInfoEncoded(true)
        var signString = String.init()
        if !(rsa?.isEmpty)! {
            let signer:APRSASigner = APRSASigner.init(privateKey: rsa)
            signString = signer.sign(orderString, withRSA2: true)
            colsure(orderStringEncoded!, signString)
        }
    }

    
}
