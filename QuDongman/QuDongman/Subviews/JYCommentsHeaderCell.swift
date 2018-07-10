//
//  JYCommentsHeaderCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYCommentsHeaderCell: JYBaseCell {
    
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    var _count:String?
    var count:String {
        set {
            commentsCountLabel.text = newValue
            _count = newValue
        }
        get {
            return _count!
        }
    }
    
    class func createCell(tableview: UITableView) -> JYCommentsHeaderCell{
        let identifier = "JYCommentsHeaderCell"
        var commentsHeadercell:JYCommentsHeaderCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYCommentsHeaderCell
        if commentsHeadercell == nil {
            commentsHeadercell = Bundle.main.loadNibNamed("JYCommentsHeaderCell", owner: nil, options: nil)?.first as! JYCommentsHeaderCell
        }
        return commentsHeadercell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
