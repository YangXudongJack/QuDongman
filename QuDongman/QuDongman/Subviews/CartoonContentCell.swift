//
//  CartoonContentCell.swift
//  QuDongman
//
//  Created by 杨旭东 on 2017/11/25.
//  Copyright © 2017年 JackYang. All rights reserved.
//

import UIKit

class CartoonContentCell : JYBaseCell {
    
    var imageview:UIImageView?
    var height:CGFloat?
    var hasUpdate:Bool?
    
    var imageName:String? {
        set {
            weak var weakSelf = self
            imageview?.sd_setImage(with: URL(string: newValue as! String),
                                  placeholderImage: UIImage.init(named: "bookCover_placeholder"),
                                  options: .retryFailed) { (image, error, cacheType, url) in
                                    if !(weakSelf?.hasUpdate)! {
                                        let size = UIScreen.main.bounds.size
                                        let scale = (image?.size.width)! / size.width
                                        weakSelf?.contentView.bounds = CGRect(x: 0, y: 0, width: size.width, height: (image?.size.height)! / scale)
                                        weakSelf?.imageview?.frame = CGRect(x: 0, y: 0, width: size.width, height: (image?.size.height)! / scale)
                                        weakSelf?.height = weakSelf?.imageview?.bounds.size.height
                                        if ((weakSelf?.updateHeightColsure) != nil) {
                                            weakSelf?.updateHeightColsure!((weakSelf?.height)!)
                                        }
                                        weakSelf?.hasUpdate = true
                                    }
            }
        }
        
        get {
            return ""
        }
    }
    
    var updateHeightColsure:((CGFloat)->Void)?
    
    class func createCell(tableview: UITableView, indexPath:IndexPath, colsure:@escaping (CGFloat)->Void) -> CartoonContentCell {
        let identifier = "CartoonContentCell-\(indexPath.row)"
        var cell:CartoonContentCell! = tableview.dequeueReusableCell(withIdentifier: identifier) as? CartoonContentCell
        if cell == nil {
            cell = CartoonContentCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell.updateHeightColsure = colsure
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scale = screenWidth / 375.0
        
        hasUpdate = false
        imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 214 * scale))
        imageview?.image = UIImage()
        self.contentView.addSubview(imageview!)
        
        self.contentView.bounds = CGRect(x: 0, y: 0, width: screenWidth, height: (imageview?.bounds.size.height)!)
        height = imageview?.bounds.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
