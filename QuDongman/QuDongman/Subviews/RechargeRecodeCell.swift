//
//  RechargeRecodeCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/5/20.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

class JYRecharge: JYBaseObject {
    @objc dynamic var created_at:String?
    @objc dynamic var bdescp:String?
    
    override init(dict: [String : AnyObject]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
}

class RechargeRecodeCell: JYBaseCell {
    
    var descLabel:UILabel?
    var resultLabel:UILabel?
    
    var _shoppingType:Bool?
    var shoppingType:Bool {
        set {
            if newValue {
                descLabel?.frame = CGRect(x: 22.5, y: 15.5, width: UIScreen.main.bounds.size.width - 92, height: 25)
                descLabel?.font = UIFont.systemFont(ofSize: 18)
                descLabel?.textAlignment = .left
                descLabel?.textColor = UIColor.titleColor_Dark()
                
                resultLabel?.frame = CGRect(x: UIScreen.main.bounds.size.width - 69.5, y: 18.5, width: 50, height: 18.5)
                resultLabel?.font = UIFont.systemFont(ofSize: 13)
                resultLabel?.textAlignment = .right
                resultLabel?.textColor = UIColor.titleColor_Dark()
            }else{
                descLabel?.frame = CGRect(x: 23.5, y: 15.5, width: 80, height: 25)
                descLabel?.font = UIFont.systemFont(ofSize: 18)
                descLabel?.textAlignment = .left
                descLabel?.textColor = UIColor.titleColor_Dark()
                
                resultLabel?.frame = CGRect(x: UIScreen.main.bounds.size.width - 106.5, y: 18.5, width: 80, height: 18.5)
                resultLabel?.font = UIFont.systemFont(ofSize: 13)
                resultLabel?.textAlignment = .right
                resultLabel?.textColor = UIColor.titleColor_lightDark()
            }
            
            _shoppingType = newValue
        }
        
        get {
            return _shoppingType!
        }
    }
    
    var _object:JYBaseObject?
    var object:JYBaseObject {
        set {
            if newValue .isMember(of: JYRecharge.self) {
                let recharge:JYRecharge = newValue as! JYRecharge
                descLabel?.text = recharge.bdescp
                resultLabel?.text = recharge.created_at
            }else{
                
            }
            
            _object = newValue
        }
        
        get {
            return _object!
        }
    }
    
    class func createCell(tableview: UITableView) -> RechargeRecodeCell{
        let identifier = "RechargeRecodeCell"
        var cell:RechargeRecodeCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? RechargeRecodeCell
        if cell == nil {
            cell = RechargeRecodeCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        descLabel = UILabel.init()
        self.contentView.addSubview(descLabel!)
        resultLabel = UILabel.init()
        self.contentView.addSubview(resultLabel!)
        
        let line = UIView(frame: CGRect(x: 0, y: 55, width: UIScreen.main.bounds.size.width, height: 1))
        line.backgroundColor = UIColor.separatorColor()
        self.contentView.addSubview(line)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
