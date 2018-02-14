//
//  CartoonCatelogCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/16.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

typealias CatelogColsure = (Int)->Void

class CartoonCatelogCell: UITableViewCell {
    
    static let identifier = "CartoonCatelogCell"
    
    var catelog : NSMutableArray?
    var titleLabel : UILabel?
    
    var readColsure : CatelogColsure?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func createCell(tableview: UITableView, info: NSArray) -> CartoonCatelogCell {
        var cell:CartoonCatelogCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonCatelogCell
        if cell == nil {
            cell = CartoonCatelogCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell.configSubview(catelog: info)
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    func configSubview(catelog : NSArray) -> Void {
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 320.0
        
        titleLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 39, height: 25))
        titleLabel?.text = "目录"
        titleLabel?.textColor  = UIColor.titleColor_Blue()
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.textAlignment = .left
        self.contentView.addSubview(titleLabel!)
        
        var number : Int = 0
        let gapX = (screenWidth - 80 * scale * 3) / 4
        var height : CGFloat = 0.0
        if catelog != nil {
            for _ in catelog {
                let gapY = CGFloat(number / 3) * (40.0 * scale + 17.0) + 17 + 45
                let button = UIButton(frame: CGRect(x: CGFloat(number % 3) * (80.0 * scale + gapX) + gapX, y: gapY, width: 80 * scale, height: 40 * scale))
                button.layer.cornerRadius = 4
                button.layer.masksToBounds = true
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.borderColor().cgColor
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.titleLabel?.textAlignment = .center
                self.contentView.addSubview(button)
                
                let info = catelog.object(at: number) as! NSDictionary
                button.setTitle( info.object(forKey: "name") as? String, for: .normal)
                button.adjustsImageWhenHighlighted = false
                
                number = number + 1
                button.tag = number
                button.addTarget(self, action: #selector(self.readAction(button:)), for: .touchUpInside)
                
                height = button.frame.origin.y + button.bounds.size.height * scale + 17
            }
        }
        self.contentView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func cellHeight() -> CGFloat {
        return self.contentView.bounds.size.height
    }
    
    func readClickColsure(colsure : CatelogColsure?) {
        readColsure = colsure
    }
    
    @objc func readAction(button : UIButton) {
        readColsure!(button.tag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
