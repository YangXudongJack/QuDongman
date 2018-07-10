//
//  JYCatelogItemCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/8.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCatelogItemCell: UITableViewCell {

    @IBOutlet weak var catelogTitleLabel: UILabel!
    
    @IBOutlet weak var lockImage: UIImageView!
    
    var _vip:Bool?
    var vip:Bool {
        set {
            lockImage.isHidden = !newValue
            _vip = newValue
        }
        
        get {
            return _vip!
        }
    }
    
    var _title:String?
    var title:String {
        set {
            catelogTitleLabel.text = newValue
            _title = newValue
        }
        
        get {
            return _title!
        }
    }
    
    class func showCatelogItem(tableview:UITableView, title:String, vip:Bool) -> JYCatelogItemCell{
        let identifier = "JYCatelogItemCell"
        var item:JYCatelogItemCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYCatelogItemCell
        if item == nil {
            item = Bundle.main.loadNibNamed("JYCatelogItemCell", owner: nil, options: nil)?.first as! JYCatelogItemCell
        }
        item.title = title;
        item.vip = vip
        return item
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
