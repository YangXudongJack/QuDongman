//
//  JYMessageCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/6/5.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYMessageCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
