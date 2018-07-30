//
//  JYAllCommentsEntranceCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYAllCommentsEntranceCell: JYBaseCell {
    
    var allCommentsColsure:(()->Void)?
    
    class func createCell(tableview: UITableView, colsure:@escaping ()->Void) -> JYAllCommentsEntranceCell{
        let identifier = "JYAllCommentsEntranceCell"
        var commentEntrancecell:JYAllCommentsEntranceCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYAllCommentsEntranceCell
        if commentEntrancecell == nil {
            commentEntrancecell = Bundle.main.loadNibNamed("JYAllCommentsEntranceCell", owner: nil, options: nil)?.first as! JYAllCommentsEntranceCell
        }
        commentEntrancecell.allCommentsColsure = colsure
        return commentEntrancecell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func selectAllCommentsEntrance(_ sender: UITapGestureRecognizer) {
        self.allCommentsColsure!()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
