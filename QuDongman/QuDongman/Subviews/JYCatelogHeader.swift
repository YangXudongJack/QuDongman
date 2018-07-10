//
//  JYCatelogHeader.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCatelogHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var serialStatusLabel: UILabel!
    
    @IBOutlet weak var titleOriginYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backOriginYConstraint: NSLayoutConstraint!
    
    var dismissColsure:(()->Void)?
    
    class func showCatelogHeader(title:String, serial:Int, colsure:@escaping ()->Void) -> JYCatelogHeader{
        let header:JYCatelogHeader = Bundle.main.loadNibNamed("JYCatelogHeader", owner: nil, options: nil)?.first as! JYCatelogHeader
        header.dismissColsure = colsure
        header.titleLabel.text = title
        header.serialStatusLabel.text = "共\(serial)话 连载中"
        return header
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var originY:Int = 93
        if DeviceManager.isIphoneX() {
            originY = 113
            titleOriginYConstraint.constant = 45
            backOriginYConstraint.constant = 45
        }
        
        self.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: originY)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismissColsure!()
    }
    
}
