//
//  JYBuyCoinCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2018/4/22.
//  Copyright © 2018年 JackYang. All rights reserved.
//

import UIKit

enum JYCoinCellType {
    case price
    case action
}

class JYBuyCoinCell: JYBaseCell {
    
    var productTitleLabel:UILabel?
    var productPriceLable:UILabel?
    var confirmButton:UIButton?
    var bottomLine:UIView?
    var coinCellType:JYCoinCellType?
    
    var coinSelectColsure:((AnyObject, JYCoinCellType)->Void)?
    
    var _info:AnyObject?
    var info:AnyObject {
        set {
            if newValue.isMember(of: JYProduct.self) {
                coinCellType = .price
                let product:JYProduct = newValue as! JYProduct
                productTitleLabel?.text = product.product_name
                productPriceLable?.text = product.total_fee_descp
                productTitleLabel?.isHidden = false
                productPriceLable?.isHidden = false
                confirmButton?.isHidden = true
                
                if bottomLine == nil {
                    bottomLine = UIView.init(frame: CGRect(x: 0, y: 55.5, width: UIScreen.main.bounds.size.width, height: 0.5))
                    bottomLine?.backgroundColor = UIColor.separatorColor()
                    self.contentView.addSubview(bottomLine!)
                }
            }else{
                coinCellType = .action
                self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 65)
                productPriceLable?.isHidden = true
                productTitleLabel?.isHidden = true
                confirmButton?.isHidden = false
                bottomLine?.removeFromSuperview()
            }
            
            _info = newValue
        }
        
        get {
            return _info!
        }
    }
    
    var price:String? {
        get {
            return ""
        }
        
        set {
            var coin:String
            if newValue == nil {
                coin = "20￥"
            }else{
                coin = newValue as! String
            }
            
            if coin == info.total_fee_descp {
                productPriceLable?.backgroundColor = UIColor.NavigationColor()
                productPriceLable?.textColor = UIColor.white
                productPriceLable?.layer.borderColor = UIColor.NavigationColor().cgColor
            }else{
                cancelSelect()
            }
        }
    }
    
    class func createCell(tableview: UITableView) -> JYBuyCoinCell{
        let identifier = "JYBuyCoinCell"
        var cell:JYBuyCoinCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? JYBuyCoinCell
        if cell == nil {
            cell = JYBuyCoinCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenSize = UIScreen.main.bounds.size
        
        let button = UIButton.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: JYBuyCoinCell.cellHeight()))
        button.addTarget(self, action: NSSelectorFromString("confirmSelect"), for: .touchUpInside)
        self.contentView.addSubview(button)
        
        productTitleLabel = UILabel.init(frame: CGRect(x: 22.5, y: 15.5, width: 150.5, height: 25))
        productTitleLabel?.font = UIFont.systemFont(ofSize: 18)
        productTitleLabel?.textColor = UIColor.titleColor_Dark()
        self.contentView.addSubview(productTitleLabel!)
        
        productPriceLable = UILabel.init(frame: CGRect(x: screenSize.width - 64 - 22.5, y: 14, width: 64, height: 28))
        productPriceLable?.font = UIFont.systemFont(ofSize: 13)
        productPriceLable?.textColor = UIColor.subTitleColor_Dark()
        productPriceLable?.layer.borderWidth = 2
        productPriceLable?.layer.borderColor = UIColor.subTitleColor_Dark().cgColor
        productPriceLable?.layer.cornerRadius = 4
        productPriceLable?.layer.masksToBounds = true
        productPriceLable?.textAlignment = .center
        self.contentView.addSubview(productPriceLable!)
        
        confirmButton = UIButton.init(frame: CGRect(x: 12, y: 22, width: screenSize.width - 24, height: 43))
        confirmButton?.setBackgroundImage(UIImage.init(named: "login_btn"), for: .normal)
        confirmButton?.setTitle("确认购买", for: .normal)
        confirmButton?.adjustsImageWhenHighlighted = false
        confirmButton?.adjustsImageWhenDisabled = false
        self.contentView.addSubview(confirmButton!)
        confirmButton?.isEnabled = false
        confirmButton?.isHidden = true
    }
    
    @objc func confirmSelect() -> Void {
        productPriceLable?.backgroundColor = UIColor.NavigationColor()
        productPriceLable?.textColor = UIColor.white
        productPriceLable?.layer.borderColor = UIColor.NavigationColor().cgColor
        
        if (coinSelectColsure != nil) {
            if coinCellType == .price{
                coinSelectColsure!(info, .price)
            }else{
                coinSelectColsure!(info, .action)
            }
        }
    }
    
    func cancelSelect() -> Void {
        productPriceLable?.textColor = UIColor.subTitleColor_Dark()
        productPriceLable?.layer.borderColor = UIColor.subTitleColor_Dark().cgColor
        productPriceLable?.backgroundColor = UIColor.clear
    }
    
    func selectColsure(colsure:@escaping (AnyObject, JYCoinCellType)->Void) {
        coinSelectColsure = colsure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat {
        return 56.0
    }

}
