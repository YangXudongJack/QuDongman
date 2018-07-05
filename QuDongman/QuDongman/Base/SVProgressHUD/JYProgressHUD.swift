//
//  JYProgressHUD.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/4.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYProgressHUD: NSObject {
    class func show() -> Void {
        SVProgressHUD.show(withStatus: nil)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    class func dismiss() -> Void {
        SVProgressHUD.dismiss()
    }
}
