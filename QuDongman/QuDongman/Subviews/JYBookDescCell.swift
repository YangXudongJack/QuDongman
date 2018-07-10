//
//  JYBookDescCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYBookDescCell: JYBaseCell {
    
    var descLabel:UILabel?
    var moreButton:UIButton?
    var height:Int?
    
    var _desc:String?
    var desc:String {
        set {
            descLabel?.text = newValue
            _desc = newValue
        }
        
        get {
            return _desc!
        }
    }
    
    class func createCell(tableview: UITableView) -> JYBookDescCell{
        let identifier = "JYBookDescCell"
        var desccell:JYBookDescCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYBookDescCell
        if desccell == nil {
            desccell = JYBookDescCell.init(style: .default, reuseIdentifier: identifier)
        }
        return desccell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        let size = UIScreen.main.bounds.size
        descLabel = UILabel(frame: CGRect(x: 16, y: 0, width: size.width - 16 * 2, height: 90))
        descLabel?.font = UIFont.systemFont(ofSize: 13)
        descLabel?.textColor = UIColor.titleColor_Dark()
        descLabel?.numberOfLines = 0
        descLabel?.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(descLabel!)
        
//        moreButton = UIButton(frame: CGRect(x: (descLabel?.frame.origin.x)! + (descLabel?.frame.size.width)! - 32, y: (descLabel?.frame.origin.y)! + (descLabel?.frame.size.height)! - 20, width: 32, height: 20))
//        moreButton?.setImage(UIImage.init(named: "desc_more"), for: .normal)
//        moreButton?.addTarget(self, action: #selector(self.moreAction), for: .touchUpInside)
//        self.contentView.addSubview(moreButton!)
        
        height = 106
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreAction() -> Void {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
