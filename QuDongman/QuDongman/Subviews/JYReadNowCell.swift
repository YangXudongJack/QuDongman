//
//  JYReadNowCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/8/12.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYReadNowCell: JYBaseCell {
    
    var readNowColsure:(()->Void)?
    
    class func createCell(tableview: UITableView,
                          colsure:@escaping ()->Void) -> JYReadNowCell{
        let identifier = "JYReadNowCell"
        var cell:JYReadNowCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYReadNowCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("JYReadNowCell",
                                            owner: nil,
                                            options: nil)?.first as! JYReadNowCell
        }
        cell.readNowColsure = colsure
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func tapReadAction(_ sender: UITapGestureRecognizer) {
        if (self.readNowColsure != nil) {
            self.readNowColsure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
