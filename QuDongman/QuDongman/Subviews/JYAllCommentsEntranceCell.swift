//
//  JYAllCommentsEntranceCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYAllCommentsEntranceCell: JYBaseCell {
    
    class func createCell(tableview: UITableView) -> JYAllCommentsEntranceCell{
        let identifier = "JYAllCommentsEntranceCell"
        var commentEntrancecell:JYAllCommentsEntranceCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYAllCommentsEntranceCell
        if commentEntrancecell == nil {
            commentEntrancecell = Bundle.main.loadNibNamed("JYAllCommentsEntranceCell", owner: nil, options: nil)?.first as! JYAllCommentsEntranceCell
        }
        return commentEntrancecell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
