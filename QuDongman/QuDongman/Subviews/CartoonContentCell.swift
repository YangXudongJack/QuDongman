//
//  CartoonContentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/25.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonContentCell : JYBaseCell {
    
    var imageview:UIImageView!
    
    var imageName:String? {
        set {
            imageview.sd_setImage(with: URL(string: newValue as! String),
                                  placeholderImage: UIImage.init(named: "bookCover_placeholder"),
                                  options: .retryFailed,
                                  completed: nil)
        }
        
        get {
            return ""
        }
    }
    
    class func createCell(tableview: UITableView) -> CartoonContentCell {
        let identifier = "CartoonContentCell"
        var cell:CartoonContentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonContentCell
        if cell == nil {
            cell = CartoonContentCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 320.0
        
        imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 320 * scale, height: 427 * scale))
        imageview.image = UIImage()
        imageview.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
