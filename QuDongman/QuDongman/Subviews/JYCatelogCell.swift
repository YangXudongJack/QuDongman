//
//  JYCatelogCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/7/7.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

enum JYCatelogButtonType {
    case catelog
    case more
}

class JYCatelogCell: JYBaseCell {
    
    @IBOutlet var catelogButtons: [UIButton]!
    
    var _catelogs:NSArray?
    var catelogs:NSArray {
        set {
            var index:Int = 1
            for catelog in newValue {
                let cate:JYCatelog = catelog as! JYCatelog
                let button:UIButton = self.contentView.viewWithTag(index) as! UIButton
                button.setImage(nil, for: .normal)
                button.setTitle(cate.name, for: .normal)
                button.isHidden = false
                index = index + 1
                
                if index == 8 {
                    break
                }
            }
            
            let button:UIButton = self.contentView.viewWithTag(index) as! UIButton
            button.isHidden = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.setTitle("···", for: .normal)
            
            _catelogs = newValue
        }
        
        get {
            return _catelogs!
        }
    }
    
    var catelogColsure:((JYCatelog, JYCatelogButtonType)->Void)?
    
    class func createCell(tableview: UITableView, colsure:@escaping (JYCatelog, JYCatelogButtonType)->Void) -> JYCatelogCell{
        let identifier = "JYCatelogCell"
        var catelogcell:JYCatelogCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYCatelogCell
        if catelogcell == nil {
            catelogcell = Bundle.main.loadNibNamed("JYCatelogCell", owner: nil, options: nil)?.first as! JYCatelogCell
        }
        catelogcell.catelogColsure = colsure
        return catelogcell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for button in catelogButtons {
            button.layer.cornerRadius = 2
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.boardColor().cgColor
            
            button.addTarget(self, action: #selector(self.selectCatelog(_:)), for: .touchUpInside)
        }
    }
    
    @objc func selectCatelog(_ sender:UIButton) -> Void {
        if sender.tag <= (_catelogs?.count)! && sender.tag != 8{
            catelogColsure!(_catelogs?.object(at: sender.tag-1) as! JYCatelog, .catelog)
        }else{
            catelogColsure!(_catelogs?.firstObject as! JYCatelog, .more)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
